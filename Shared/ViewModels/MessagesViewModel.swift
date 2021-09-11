//
//  MessagesViewModel.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import CryptoKit


class MessagesViewModel: ObservableObject {
    
    @Published var groups = [Group]()
    @Published var chats = [Chat]()
    @Published var currentUser = User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", publicToken: "", groups: [], favourites: [])
    @Published var favourites = [User]()

    @Published var searchTerm: String = ""
    

    init() {
        let userID = getUserID()
        registerPushNotification(userID: userID)
        fetchCurrentUser(userID: userID)
        fetchMessages(userID: userID)
    }
    
    
    func getUserID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    
    func registerPushNotification(userID: String) {
        let pushManager = PushNotificationManager(userID: userID)
        pushManager.registerForPushNotifications()
    }
    
    
    func fetchCurrentUser(userID: String) {
        Firestore.firestore().collection("users").document(userID).addSnapshotListener { documentSnapshot, error in
            
            //Clear the favourites model before we populate it with updates (SHIT)
            self.currentUser = User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", publicToken: "", groups: [""], favourites: [""])
            
            guard let document = documentSnapshot else { return }
            try? self.currentUser = document.data(as: User.self) ?? User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", publicToken: "", groups: [""], favourites: [""])
            
            //Watch out for a race condition on this thing!!!! Sometimes getting an empty array in the current user favourites
            self.fetchFavourites()
        }
    }
    
    
    
    func fetchFavourites() {
        Firestore.firestore().collection("users").whereField("id", in: self.currentUser.favourites).addSnapshotListener { (querySnapshot, error) in
            
            self.favourites.removeAll()
            guard let documents = querySnapshot?.documents else { return }
            
            self.favourites = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }
    
    

    func fetchMessages(userID: String) {
        
        Firestore.firestore().collection("groups").whereField("members", arrayContains: userID).addSnapshotListener { (documentSnapshot, error) in
            
            print("FIRED - fetchMessages")
            
            //Clear the chat model before we populate it with updates
            self.chats.removeAll()
            
            guard let documents = documentSnapshot?.documents else { return }

            self.groups = documents.map { (queryDocumentSnapshot) -> Group in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let createdBy = data["createdBy"] as? String ?? ""
                let lastMessage = data["lastMessage"] as? String ?? ""
                let members = data["members"] as? [String] ?? [""]
                let createdOn = (data["createdOn"] as? Timestamp)?.dateValue() ?? Date()
                
                
                //get users which aren't me and where the group is within the group array
                self.fetchMessagesReciever(uid: userID, groupId: id, lastMessage: lastMessage)
                
//                self.getMembersOfGroupByID(userID: userID, members: members, lastMessage: lastMessage, groupId: id)
                
                return Group(id: id, createdBy: createdBy, members: members, createdOn: createdOn, lastMessage: lastMessage)
            }
        }
    }
    
    
//    func getMembersOfGroupByID(userID: String, members: [String], lastMessage: String, groupId: String) {
//
////        Firestore.firestore().collection("users").whereField("id", in: members).addSnapshotListener { querySnapshot, error in
//        print("FIRED - getMembersOfGroupByID")
//
//        Firestore.firestore().collection("users").whereField("id", in: members).whereField("id", isNotEqualTo: userID).addSnapshotListener { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else { return }
//
//            //Clear the chat model before we populate it with updates
//            self.chats.removeAll()
//
//            self.chats.append(contentsOf: documents.map({ (queryDocumentSnapshot) -> Chat in
//
//                let data = queryDocumentSnapshot.data()
//
//                let recieverId = data["id"] as? String ?? ""
//                let recieverName = data["name"] as? String ?? ""
//                let recieverMobileNumber = data["mobileNumber"] as? String ?? ""
//                let recieverFcmToken = data["fcmToken"] as? String ?? ""
//                let publicToken = data["publicToken"] as? String ?? ""
//                let recieverImageUrl = data["imageUrl"] as? String ?? ""
//                let recieverGroups = data["groups"] as? [String] ?? [""]
//                let revieverFavourites = data["favourites"] as? [String] ?? [""]
//
//                return Chat(reciever: User(id: recieverId, name: recieverName, mobileNumber: recieverMobileNumber, imageUrl: recieverImageUrl, fcmToken: recieverFcmToken, publicToken: publicToken, groups: recieverGroups, favourites: revieverFavourites), groupId: groupId, lastMessage: lastMessage)
//
//            }))
//
//        }
//    }
    
    
    private func fetchMessagesReciever(uid: String, groupId: String, lastMessage: String) {

        print("FIRED - fetchMessagesReciever")

        Firestore.firestore().collection("users").whereField("groups", arrayContains: groupId).whereField("id", isNotEqualTo: uid).getDocuments { querySnapshot, error in
            
//        Firestore.firestore().collection("users").whereField("groups", arrayContains: groupId).whereField("id", isNotEqualTo: uid).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }

            self.chats.append(contentsOf: documents.map({ (queryDocumentSnapshot) -> Chat in

                let data = queryDocumentSnapshot.data()

                let recieverId = data["id"] as? String ?? ""
                let recieverName = data["name"] as? String ?? ""
                let recieverMobileNumber = data["mobileNumber"] as? String ?? ""
                let recieverFcmToken = data["fcmToken"] as? String ?? ""
                let publicToken = data["publicToken"] as? String ?? ""
                let recieverImageUrl = data["imageUrl"] as? String ?? ""
                let recieverGroups = data["groups"] as? [String] ?? [""]
                let revieverFavourites = data["favourites"] as? [String] ?? [""]

                return Chat(reciever: User(id: recieverId, name: recieverName, mobileNumber: recieverMobileNumber, imageUrl: recieverImageUrl, fcmToken: recieverFcmToken, publicToken: publicToken, groups: recieverGroups, favourites: revieverFavourites), groupId: groupId, lastMessage: lastMessage)

            }))

        }
    }
    
}
