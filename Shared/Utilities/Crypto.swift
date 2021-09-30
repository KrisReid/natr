//
//  Crypto.swift
//  natr
//
//  Created by Kris Reid on 09/09/2021.
//

import Foundation
import CryptoKit
import Security
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class Crypto: ObservableObject {
    
    func exportPublicKey(_ publicKey: Curve25519.KeyAgreement.PublicKey) -> String {
        let rawPublicKey = publicKey.rawRepresentation
        let publicKeyBase64 = rawPublicKey.base64EncodedString()
        let percentEncodedPublicKey = publicKeyBase64.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return percentEncodedPublicKey
    }
    
    
    func importPublicKey(_ publicKey: String) throws -> Curve25519.KeyAgreement.PublicKey {
        let publicKeyBase64 = publicKey.removingPercentEncoding!
        let rawPublicKey = Data(base64Encoded: publicKeyBase64)!
        return try Curve25519.KeyAgreement.PublicKey(rawRepresentation: rawPublicKey)
    }
    
    
    func generateCryptoKeys() -> String {
        let privateKey = Curve25519.KeyAgreement.PrivateKey()
        let publicKey = privateKey.publicKey
        storePrivateKey(privateKey)
        return exportPublicKey(publicKey)
    }
    
    
    func storePrivateKey(_ privateKey: Curve25519.KeyAgreement.PrivateKey) {
        let query = [
            kSecValueData: privateKey.rawRepresentation,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "private-key",
            kSecAttrAccount: "natr"
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            print("Error: \(status)")
        } else {
            print("PRIVATE KEY HAS BEEN STORED")
        }
    }
    
    
    func retirevePrivateKey() -> Curve25519.KeyAgreement.PrivateKey {
        let query = [
            kSecAttrService: "private-key",
            kSecAttrAccount: "natr",
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        let rawPrivateKey = result as? Data
        
        print("PRIVATE KEY IS RETRIEVED")
        return try! Curve25519.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKey!)
    }
    
    
    func deletePrivateKey() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "private-key",
            kSecAttrAccount: "natr"
            ] as CFDictionary
        
        SecItemDelete(query)
        print("DELETED PRIVATE KEY FROM STORE")
    }
    
    
    func generateSymmetricKey(publicToken: String) throws -> SymmetricKey {
        
        let salt = Bundle.main.infoDictionary?["SYMMETRIC_SALT"] as! String
        let privateKey = retirevePrivateKey()
        let publicKey = try? importPublicKey(publicToken)
        let sharedSecret = try privateKey.sharedSecretFromKeyAgreement(with: publicKey!)
        
        let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: salt.data(using: .utf8)!,
            sharedInfo: Data(),
            outputByteCount: 32
        )
        return symmetricKey
    }
    
    
    func encryptText(text: String, symmetricKey: SymmetricKey) throws -> String {
        let textData = text.data(using: .utf8)!
        let encrypted = try AES.GCM.seal(textData, using: symmetricKey)
        return encrypted.combined!.base64EncodedString()
    }
    
    
    func decryptText(text: String, symmetricKey: SymmetricKey) -> String {
        do {
            guard let data = Data(base64Encoded: text) else {
                return "Could not decode text: \(text)"
            }
            
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            
            guard let text = String(data: decryptedData, encoding: .utf8) else {
                return "Could not decode data: \(decryptedData)"
            }
            
            return text
        } catch let error {
            return "Error decrypting message: \(error.localizedDescription)"
        }
    }
    
}
