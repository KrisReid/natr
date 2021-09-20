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
import Contacts


class MessagesViewModel: ObservableObject {
    
    @Published var groups = [Group]()
    @Published var chats = [Chat]()
    @Published var currentUser = User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", publicToken: "", groups: [], favourites: [])
    @Published var favourites = [User]()
    @Published var searchTerm: String = ""

    
    
//    func fetchMessages() async {
//        do {
//            let uid = Auth.auth().currentUser?.uid ?? ""
//            self.registerPushNotification(userID: uid)
//            try await self.fetchUserByID(userID: uid)
//            self.fetchMessageByUserID(userID: uid)
//        }
//        catch {
//            print("Error")
//        }
//    }
//
//
//    func registerPushNotification(userID: String) {
//        let pushManager = PushNotificationManager(userID: userID)
//        pushManager.registerForPushNotifications()
//    }
//
//
//    private func fetchUserByID(userID: String) async throws {
//        do {
//            let document = try await Firestore.firestore().collection("users").document(userID).getDocument().data(as: User.self)
//            guard let user = document else { return }
//            DispatchQueue.main.async {
//                self.currentUser = user
//            }
//            self.fetchFavourites(user: user)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
//
//
//    private func fetchFavourites(user: User) {
//        Firestore.firestore().collection("users").whereField("id", in: user.favourites).addSnapshotListener { (querySnapshot, error) in
//            self.favourites.removeAll()
//            guard let documents = querySnapshot?.documents else { return }
//            self.favourites = documents.compactMap { (queryDocumentSnapshot) -> User? in
//                return try? queryDocumentSnapshot.data(as: User.self)
//            }
//        }
//    }
//
//
//    func fetchMessageByUserID(userID: String) {
//        Firestore.firestore().collection("groups").whereField("members", arrayContains: userID).addSnapshotListener { (documentSnapshot, error) in
//
//            //Clear the chat model before we populate it with updates
//            self.chats.removeAll()
//
//            guard let documents = documentSnapshot?.documents else { return }
//
//            self.groups = documents.map { (queryDocumentSnapshot) -> Group in
//                let data = queryDocumentSnapshot.data()
//                let id = data["id"] as? String ?? ""
//                let createdBy = data["createdBy"] as? String ?? ""
//                let lastMessage = data["lastMessage"] as? String ?? ""
//                let members = data["members"] as? [String] ?? [""]
//                let createdOn = (data["createdOn"] as? Timestamp)?.dateValue() ?? Date()
//
//                //get users which aren't me and where the group is within the group array
//                self.fetchMessagesReciever(uid: userID, groupId: id, lastMessage: lastMessage)
//
//                return Group(id: id, createdBy: createdBy, members: members, createdOn: createdOn, lastMessage: lastMessage)
//            }
//        }
//    }
//
//
//    private func fetchMessagesReciever(uid: String, groupId: String, lastMessage: String) {
//
//        Firestore.firestore().collection("users").whereField("groups", arrayContains: groupId).whereField("id", isNotEqualTo: uid).getDocuments { querySnapshot, error in
//
//            guard let documents = querySnapshot?.documents else { return }
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
    

    
    
    init() {
        let userID = getUserID()
        registerPushNotification(userID: userID)
        fetchCurrentUser(userID: userID)
        fetchMessages(userID: userID)
    }


    func getUserID() -> String {
        print("11111111111")
        return Auth.auth().currentUser?.uid ?? ""
    }


    func registerPushNotification(userID: String) {
        print("33333333333")
        let pushManager = PushNotificationManager(userID: userID)
        pushManager.registerForPushNotifications()
        print("444444444444")
    }


    func fetchCurrentUser(userID: String) {
        print("5555555555555")
        Firestore.firestore().collection("users").document(userID).addSnapshotListener { documentSnapshot, error in
            print("666666666666")

            //Clear the favourites model before we populate it with updates (SHIT)
            self.currentUser = User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", publicToken: "", groups: [""], favourites: [""])

            guard let document = documentSnapshot else { return }
            try? self.currentUser = document.data(as: User.self) ?? User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", publicToken: "", groups: [""], favourites: [""])

            //Watch out for a race condition on this thing!!!! Sometimes getting an empty array in the current user favourites
            print("77777777777777")
            self.fetchFavourites()
        }
    }



    func fetchFavourites() {
        print("88888888888888")
        Firestore.firestore().collection("users").whereField("id", in: self.currentUser.favourites).addSnapshotListener { (querySnapshot, error) in

            self.favourites.removeAll()
            guard let documents = querySnapshot?.documents else { return }

            self.favourites = documents.compactMap { (queryDocumentSnapshot) -> User? in
                print("999999999999999999")
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }



    func fetchMessages(userID: String) {

        print("1111")

        Firestore.firestore().collection("groups").whereField("members", arrayContains: userID).addSnapshotListener { (documentSnapshot, error) in

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

                print("2222")

                //get users which aren't me and where the group is within the group array
                self.fetchMessagesReciever(uid: userID, groupId: id, lastMessage: lastMessage)

                print("3333")

                return Group(id: id, createdBy: createdBy, members: members, createdOn: createdOn, lastMessage: lastMessage)
            }
        }
    }




    private func fetchMessagesReciever(uid: String, groupId: String, lastMessage: String) {
        print("4444")

        Firestore.firestore().collection("users").whereField("groups", arrayContains: groupId).whereField("id", isNotEqualTo: uid).getDocuments { querySnapshot, error in

            print("5555")
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

                print("6666")

                return Chat(reciever: User(id: recieverId, name: recieverName, mobileNumber: recieverMobileNumber, imageUrl: recieverImageUrl, fcmToken: recieverFcmToken, publicToken: publicToken, groups: recieverGroups, favourites: revieverFavourites), groupId: groupId, lastMessage: lastMessage)

            }))

        }
    }
    
    
    
    
    
    // RELATED TO CONTACTS VIEW SPECIFICALLY
    
    
    
    @Published var contacts = [ContactInfo.init(firstName: "", lastName: "", mobileNumber: "")]
    @Published var mobileArray = [ContactInfo.init(firstName: "", lastName: "", mobileNumber: "")]
    
    func requestAccess() {
        let store = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            self.getContacts()
        case .denied:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContacts()
                }
            }
        case .restricted, .notDetermined:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContacts()
                }
            }
        @unknown default:
            print("error")
        }
    }
    
    
    func getContacts() {
        DispatchQueue.main.async {
            self.contacts = self.fetchingContacts()
        }
    }
    
    
    func fetchingContacts() -> [ContactInfo] {
        var contacts = [ContactInfo]()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try CNContactStore().enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                //Remove any spaces in the contact number
                let mobile = contact.phoneNumbers.first?.value.stringValue ?? ""
                var mobileNumber = String(mobile.filter { !" \n\t\r".contains($0) })
                //Modify anything starting with 0 to be +44 instead
                if mobileNumber.prefix(1) == "0" {
                    mobileNumber.remove(at: mobileNumber.startIndex)
                    mobileNumber.insert(contentsOf: "+44", at: mobileNumber.startIndex)
                }
                //Remove non +44 numbers
                if mobileNumber.starts(with: "+44") {
                    //Save the contact in the contact array
                    contacts.append(ContactInfo(firstName: contact.givenName, lastName: contact.familyName, mobileNumber: mobileNumber))
                }
            })
        } catch let error {
            print("Failed", error)
        }
        contacts = contacts.sorted {
            $0.firstName < $1.firstName
        }
        checkContacts(contacts: contacts)
        return contacts
    }
    
    
    
    func checkContacts(contacts: [ContactInfo]) {
        
        self.mobileArray.removeAll()
        for contact in contacts {
            Firestore.firestore().collection("users").whereField("mobileNumber", isNotEqualTo: currentUser.mobileNumber).whereField("mobileNumber", isEqualTo: contact.mobileNumber).getDocuments { documentSnapshot, error in
                
                guard let documents = documentSnapshot?.documents else { return }
                
                documents.map { QueryDocumentSnapshot in
                    let data = QueryDocumentSnapshot.data()
                    let mobileNumber = data["mobileNumber"] as? String ?? ""
                    let firstName = data["name"] as? String ?? ""
                    self.mobileArray.append(ContactInfo(firstName: firstName, lastName: "", mobileNumber: mobileNumber))
                }
            }
        }
    }
    
    

    
    
    
    
    
    
    func createChat(mobileNumber: String) async throws -> String {
        
        var chatID = ""
        
        do {
            // FETCH MY UID
            let uid = Auth.auth().currentUser?.uid ?? ""
            
            // FETCH THE USER OF THE PASSED MOBILE NUMBER
            let user = try await fetchUserByMobile(mobileNumber: mobileNumber)
            let contactID = user[0].id
            
            //DOES A CHAT ALREADY EXIST???
            chatID = try await checkGroupExistance(uid: uid, contactUID: contactID)
            
            //CREATE CHAT IN DATABASE IF REQUIRED
            if chatID.isEmpty {
                createGroup(uid: uid, contactUID: contactID)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        return chatID
    }
    
    
    private func fetchUserByMobile(mobileNumber: String) async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").whereField("mobileNumber", isEqualTo: mobileNumber).getDocuments()
        return snapshot.documents.compactMap { document in
            try? document.data(as: User.self)
        }
    }
    
    
    private func checkGroupExistance(uid: String, contactUID: String) async throws -> String {
        let snapshot = try await Firestore.firestore().collection("groups").whereField("members", isEqualTo: [uid, contactUID]).getDocuments()
        var id = ""
        snapshot.documents.compactMap { document in
            let group = try? document.data(as: Group.self)
            id = group?.id ?? ""
        }
        return id
    }
    
    
    private func createGroup(uid: String, contactUID: String) {
        
        let db = Firestore.firestore().collection("groups").document()
        let group = Group(id: db.documentID, createdBy: uid, members: [uid, contactUID], createdOn: Date(), lastMessage: "")

        try? db.setData(from: group, completion: { (err) in

            //Can probably replace this with the function in ChatViewModel.
            do {
                let messageDB = Firestore.firestore().collection("groups").document(db.documentID).collection("messages").document()
                let message = Message(id: messageDB.documentID, content: "Hello 👋", userId: uid, timeDate: Timestamp(date: Date()))
                try messageDB.setData(from: message)

                //save latest message
                Firestore.firestore().collection("groups").document(db.documentID).setData(["lastMessage":"Hello 👋"], merge: true)
            }
            catch {
                print(error.localizedDescription)
            }


            // Add the group chat ID to the user
            Firestore.firestore().collection("users").document(uid).updateData(["groups" : FieldValue.arrayUnion([db.documentID])])


            //Add the group chat ID to the other user
            Firestore.firestore().collection("users").document(contactUID).updateData(["groups" : FieldValue.arrayUnion([db.documentID])])
        })
            
    }
    
    
    

    
    
    
}
