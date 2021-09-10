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
        fetchCurrentUser()
        fetchMessages()
    }
    
    
    func fetchCurrentUser() {
        let uid = Auth.auth().currentUser?.uid ?? "bHAMnTf0LkWvbo90vtzVnx1EPAs2"
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else { return }

            try? self.currentUser = document.data(as: User.self) ?? User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", publicToken: "", groups: [], favourites: [])
            
            //fetch usersfavourites
            Firestore.firestore().collection("users").whereField("id", in: self.currentUser.favourites).addSnapshotListener { (querySnapshot, error) in

                guard let documents = querySnapshot?.documents else { return }
                self.favourites = documents.compactMap { (queryDocumentSnapshot) -> User? in
                    return try? queryDocumentSnapshot.data(as: User.self)
                }
            }
            
            //Register for push notifications
            let pushManager = PushNotificationManager(userID: uid)
            pushManager.registerForPushNotifications()
        }
    }
    
    

    func fetchMessages() {

        let uid = Auth.auth().currentUser?.uid ?? "bHAMnTf0LkWvbo90vtzVnx1EPAs2"

        Firestore.firestore().collection("groups").whereField("members", arrayContains: uid).addSnapshotListener { (documentSnapshot, error) in
            
            guard let documents = documentSnapshot?.documents else { return }

            self.groups = documents.map { (queryDocumentSnapshot) -> Group in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let createdBy = data["createdBy"] as? String ?? ""
                let lastMessage = data["lastMessage"] as? String ?? ""
                let members = data["members"] as? [String] ?? [""]
                let createdOn = (data["createdOn"] as? Timestamp)?.dateValue() ?? Date()

                //Clear the chat model before we populate it with updates (SHIT)
                self.chats.removeAll()
                
                
                // When a message gets updated, then I am updating the "Groups" and then calling the "fetchMessagesReciever" function (twice for my user) which is the thing that actually then goes on to display the update. But because this is just appending to the array we are seeing duplicate entries upon a new entry being added
                
                //SOLUTIONS
                // 1. Clear the array before reloading it (expensive)
                // 2. Only Update the certain fields somehow? (If last message updates)
                // 3. Add the last message data into the User model? ----------
                // 4.

                //get users which aren't me and where the group is within the group array
                self.fetchMessagesReciever(uid: uid, groupId: id, lastMessage: lastMessage)
                
                return Group(id: id, createdBy: createdBy, members: members, createdOn: createdOn, lastMessage: lastMessage)
            }
        }
    }
    
    
    private func fetchMessagesReciever(uid: String, groupId: String, lastMessage: String) {
        
        Firestore.firestore().collection("users").whereField("groups", arrayContains: groupId).whereField("id", isNotEqualTo: uid).getDocuments { (querySnapshot, error) in
                        
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
