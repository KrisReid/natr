//
//  HashingPOCHelper.swift
//  natr
//
//  Created by Kris Reid on 05/09/2021.
//

import Foundation
import CryptoKit
import CommonCrypto

class HashingPOCHelper: ObservableObject {
    
    @Published var hash: String = ""
    
    let iv = AES.GCM.Nonce()
    var encryptedData: Data!
    var key = SymmetricKey(size: .bits128)
    var decryptedData: String!
    
    
    
    //Create a hash from a string
    func hashMeBaby (value: String) {
        let data = Data(value.utf8)
        let digest = SHA256.hash(data: data)
        hash = digest.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    //Encrypt Data
    func encryptData(encryptString: String) {
        do {
            let message = encryptString.data(using: .utf8)!
            encryptedData = try AES.GCM.seal(message, using: key, nonce: iv).combined
            print(encryptedData!)
            /////
            ////
            ///
            //
            decryptData(decryptToData: encryptedData, key: key)
        } catch {
            print("Error")
        }
    }
    
    //Decrypt Data
    func decryptData(decryptToData: Data, key: SymmetricKey) {
        let sealedBoxToOpen = try! AES.GCM.SealedBox(combined: decryptToData)

        if let decryptedData = try? AES.GCM.open(sealedBoxToOpen, using: key) {
            self.decryptedData = String(data: decryptedData, encoding: .utf8)!
        } else {
            print("error", CryptoKitError.self)
        }
    }
        
    
}
 
