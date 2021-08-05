//
//  CreateChatViewModel.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift


class CreateChatViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        let uid = Auth.auth().currentUser?.uid ?? ""

        Firestore.firestore().collection("users").whereField("id", isNotEqualTo: uid).addSnapshotListener { (documentSnapshot, error) in
            guard let documents = documentSnapshot?.documents else { return }
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }
    
}
