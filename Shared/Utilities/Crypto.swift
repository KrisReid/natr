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
    
    func generateCryptoKeys() {
        // generate key pair
        let privateKey = Curve25519.KeyAgreement.PrivateKey()
        let publicKey = privateKey.publicKey
        
        //Store the Proviate Key
        
        //Store the Public Key
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").whereField("id", isEqualTo: uid).addSnapshotListener { (documentSnapshot, error) in
            guard let documents = documentSnapshot?.documents else { return }
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
        
    }
    
}
