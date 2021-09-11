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

//WILL PROBABLY END UP IN MESSAGESVIEWMODEL



class ContactsViewModel: ObservableObject {
    
    @Published var contacts = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil, mobileNumber: "")]
//    @Published var tempMobileArray = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil, mobileNumber: "")]
    @Published var tempMobileArray = []
    @Published var mobileArray = []
    
    
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
                    contacts.append(ContactInfo(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value, mobileNumber: mobileNumber))
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
        for contact in contacts {
//            print("\(contact.firstName): \(contact.mobileNumber)")
            tempMobileArray.append(contact.mobileNumber)
        }
        doStuff()
        
    }
    
   
    
    func doStuff() {
        for mobile in tempMobileArray {
            Firestore.firestore().collection("users").whereField("mobileNumber", isEqualTo: mobile).getDocuments { documentSnapshot, error in
                
                guard let documents = documentSnapshot?.documents else { return }
                
                self.mobileArray.append(contentsOf: documents.map({ (queryDocumentSnapshot) -> Mobile in
                    let data = queryDocumentSnapshot.data()
                    let mobileNumber = data["mobileNumber"] as? String ?? ""
                    print("mobileNumber: \(mobileNumber)")
                    return Mobile(mobileNumber: mobileNumber)
                }))
            }
        }
    }
    
    
    
    
    
    func getContacts() {
        DispatchQueue.main.async {
            self.contacts = self.fetchingContacts()
        }
    }

    
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
    
}
