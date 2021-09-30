//
//  ChatViewModel.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class ChatViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    @Published var lastMessageId: String = ""
    
    
    init(groupId: String, recipientPublicToken: String, usersPublicToken: String) {
        fetchGroupMessages(groupId: groupId, recipientPublicToken: recipientPublicToken, usersPublicToken: usersPublicToken)
    }
    
    
    func fetchLastMessageID() {
        self.lastMessageId = messages.last?.id ?? ""
    }
    
    
    func fetchGroupMessages(groupId: String, recipientPublicToken: String, usersPublicToken: String) {
        
        do {
            let encryption = Crypto()
            let symmetricKey = try encryption.generateSymmetricKey(publicToken: recipientPublicToken)
  
            Firestore.firestore().collection("groups").document(groupId).collection("messages").order(by: "timeDate").addSnapshotListener { documentSnapshot, error in
                
                guard let documents = documentSnapshot?.documents else { return }
                
                self.messages = documents.compactMap { (queryDocumentSnapshot) -> Message in
                    let data = queryDocumentSnapshot.data()
                    
                    let id = data["id"] as? String ?? ""
                    let content = data["content"] as? String ?? ""
                    let userId = data["userId"] as? String ?? ""
                    let timeDate = (data["timeDate"] as? Timestamp)?.dateValue() ?? Date()
                    
                    let decryptText = encryption.decryptText(text: content, symmetricKey: symmetricKey)
                    
                    return Message(id: id, content: decryptText, userId: userId, timeDate: Timestamp(date: timeDate))
                    
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    
    
    func postMessage(content: String, userId: String, groupId: String, fcmToken: String, publicToken: String, senderName: String) {
        do {
            
            //Encrypt the message
            let encryption = Crypto()
            let symmetricKey = try encryption.generateSymmetricKey(publicToken: publicToken)
            let encryptedText = try encryption.encryptText(text: content, symmetricKey: symmetricKey)
            
            let newMessageRef = Firestore.firestore().collection("groups").document(groupId).collection("messages").document()
            let message = Message(id: newMessageRef.documentID, content: encryptedText, userId: userId, timeDate: Timestamp(date: Date()))
            try newMessageRef.setData(from: message, completion: { (err) in
                
                // send push
                //NEED TO ADD ENCRYPTION HERE
                let sender = PushNotificationSender()
                sender.sendPushNotification(to: fcmToken, title: senderName, body: content)
                
                //save latest message
                //NEED TO ADD ENCRYPTION HERE
                Firestore.firestore().collection("groups").document(groupId).setData(["lastMessage":content], merge: true)
                // Firestore.firestore().collection("groups").document(groupId).setData(["lastMessage":encryptedText], merge: true)
                
                //fetch last message in the array
                self.fetchLastMessageID()
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}
