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
        let rawPubliceKey = Data(base64Encoded: publicKeyBase64)!
        return try Curve25519.KeyAgreement.PublicKey(rawRepresentation: rawPubliceKey)
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
            print("Success!!!!!")
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
        return try! Curve25519.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKey!)
    }
    
    
    func deletePrivateKey() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "private-key",
            kSecAttrAccount: "natr"
            ] as CFDictionary
        
        SecItemDelete(query)
    }
    
}
