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
    
    
    init(groupId: String) {
        fetchGroupMessages(groupId: groupId)
    }
    
    
    func fetchLastMessageID() {
        self.lastMessageId = messages.last?.id ?? ""
    }

    
    func fetchGroupMessages(groupId: String) {
        Firestore.firestore().collection("groups").document(groupId).collection("messages").order(by: "timeDate").addSnapshotListener { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents else { return }
            self.messages = documents.compactMap { (queryDocumentSnapshot) -> Message? in
                return try? queryDocumentSnapshot.data(as: Message.self)
            }
        }
    }
    
    
    func postMessage(content: String, userId: String, groupId: String, fcmToken: String, senderName: String) {
        do {
            
//            let encryption = HashingPOCHelper()
//            let encryptedContent = encryption.encryptData(encryptString: content)
            
            
            let newMessageRef = Firestore.firestore().collection("groups").document(groupId).collection("messages").document()
            let message = Message(id: newMessageRef.documentID, content: content, userId: userId, timeDate: Timestamp(date: Date()))
            try newMessageRef.setData(from: message, completion: { (err) in
                
                // send push
                let sender = PushNotificationSender()
                sender.sendPushNotification(to: fcmToken, title: senderName, body: content)
                
                //save latest message
                Firestore.firestore().collection("groups").document(groupId).setData(["lastMessage":content], merge: true)
                
                //fetch last message in the array
                self.fetchLastMessageID()
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}
