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
    @Published var decryptedData: String = ""
    
    let iv = AES.GCM.Nonce()
    var encryptedData: Data!
    var key = SymmetricKey(size: .bits128)
    @Published var content: Content?
    
    
    //Create a hash from a string
    func hashMeBaby (value: String) {
        let data = Data(value.utf8)
        let digest = SHA256.hash(data: data)
        hash = digest.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    
//    //Encrypt Data
//    func encryptData(encryptString: String) -> String {
//        do {
//            
//            print("Key: \(key)")
//            let message = encryptString.data(using: .utf8)!
//            encryptedData = try AES.GCM.seal(message, using: key, nonce: iv).combined
//            
//            //SAVE THE DATA FOR LATER USE
//            //WOULD ULTIMATELY NEED TO STORE THIS IN THE DATABASE OR LOCALLY? (STORING TOGETHER IN THE DB IS DUMB?)
//            //IS THE KEY UNIQUE OR SHARED ???
//            content = Content(contentMessage: encryptedData, contentKey: key)
//            return encryptedData.base64EncodedString()
//            
////            decryptData(decryptToData: encryptedData, key: key)
//            
//        } catch {
//            print("Error")
//            return "Error"
//        }
//    }
//    
//    //Decrypt Data
//    func decryptData(decryptToData: Data, key: SymmetricKey) {
//        let sealedBoxToOpen = try! AES.GCM.SealedBox(combined: decryptToData)
//
//        if let decryptedData = try? AES.GCM.open(sealedBoxToOpen, using: key) {
//            self.decryptedData = String(data: decryptedData, encoding: .utf8)!
//        } else {
//            print("error", CryptoKitError.self)
//        }
//    }
        
    
}
 
