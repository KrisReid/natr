//
//  ContactsViewModel.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import Foundation
import Contacts
import FirebaseAuth
import FirebaseFirestore


class ContactsViewModel: ObservableObject {
    
    @Published var contacts = [ContactInfo.init(firstName: "", lastName: "", mobileNumber: "")]
    @Published var mobileArray = [ContactInfo.init(firstName: "", lastName: "", mobileNumber: "")]
    @Published var mobileNumber: String = ""
    
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
//            Firestore.firestore().collection("users").whereField("mobileNumber", isEqualTo: contact.mobileNumber).getDocuments { documentSnapshot, error in
            Firestore.firestore().collection("users").whereField("mobileNumber", isNotEqualTo: mobileNumber).whereField("mobileNumber", isEqualTo: contact.mobileNumber).getDocuments { documentSnapshot, error in
                
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
    
    
    
    
    func createChat() {
        
        // HOW DO I GET THE PHONE NUMBER !!!!!!!!!!
        
        print("78888765566")
        print(mobileNumber)
        
        Firestore.firestore().collection("user").whereField("mobileNumber", isEqualTo: mobileNumber).getDocuments { documentSnapshot, error in
            
            print("222222222222")
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in documentSnapshot!.documents {
                    print("33333333333333333")
                    print("\(document.documentID) => \(document.data())")
                }
                print("444444444444444")
            }
        }
        
        
//        do {
//            let uid = Auth.auth().currentUser?.uid ?? ""
//            let db = Firestore.firestore().collection("groups").document()
//            //Might need to chage the date to be a timestamp by not using the model and just use an Dictionary of [String:Any]
//            let group = Group(id: db.documentID, createdBy: uid, members: [uid, "2345676543234567"], createdOn: Date(), lastMessage: "")
//
//            try db.setData(from: group, completion: { (err) in
//
//                // Add a Message to the Group Chat as it does it already
//
//                //Can probably replace this with the function in ChatViewModel.
//                do {
//                    let messageDB = Firestore.firestore().collection("groups").document(db.documentID).collection("messages").document()
//                    let message = Message(id: messageDB.documentID, content: "Hello 👋", userId: uid, timeDate: Timestamp(date: Date()))
//                    try messageDB.setData(from: message)
//
//                    //save latest message
//                    Firestore.firestore().collection("groups").document(db.documentID).setData(["lastMessage":"Hello 👋"], merge: true)
//                }
//                catch {
//                    print(error.localizedDescription)
//                }
//
//
//                // Add the group chat ID to the user
//                Firestore.firestore().collection("users").document(uid).collection("groups").document(db.documentID)
//
//
//                //Add the group chat ID to the other user
//
//
//            })
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//
        
    }
    
}
