//
//  Crypto.swift
//  natr
//
//  Created by Kris Reid on 09/09/2021.
//

import Foundation
import CryptoKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class Crypto: ObservableObject {
    
    func exportPublicKey(_ publicKey: Curve25519.KeyAgreement.PublicKey) -> String {
        let rawPublicKey = publicKey.rawRepresentation
        let publicKeyBase64 = rawPublicKey.base64EncodedString()
        let percentEncodedPublicKey = publicKeyBase64.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return percentEncodedPublicKey
        
        //TEST THE CONVERSION BACK WORKS
        
//        do {
//            let a = try importPublicKey(percentEncodedPublicKey)
//            print("1111111111")
//            print(a)
//        } catch {
//            print("The file could not be loaded")
//        }
        
    }
    
    
    func importPublicKey(_ publicKey: String) throws -> Curve25519.KeyAgreement.PublicKey {
        let publicKeyBase64 = publicKey.removingPercentEncoding!
        let rawPubliceKey = Data(base64Encoded: publicKeyBase64)!
        return try Curve25519.KeyAgreement.PublicKey(rawRepresentation: rawPubliceKey)
    }
    
    
    
    func generateCryptoKeys() -> String {
        let privateKey = Curve25519.KeyAgreement.PrivateKey()
        let publicKey = privateKey.publicKey
        
        //Store the Private Key (On KeyChain)
        
        
        //Store the Public Key in Firebase
        return exportPublicKey(publicKey)
        
    }
    
}
