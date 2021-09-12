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
    
}
