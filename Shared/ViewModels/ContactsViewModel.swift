//
//  ContactsViewModel.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import Foundation
import Contacts
import FirebaseAuth

//WILL PROBABLY END UP IN MESSAGESVIEWMODEL


class ContactsViewModel: ObservableObject {
    
    @Published var contacts = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil, mobileNumber: "")]
    
//    var storedContact = ["07432426798", "+447515509832", "07432426788"]
    
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
                
                //Save the contact in the contact array
                contacts.append(ContactInfo(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value, mobileNumber: mobileNumber))

            })
        } catch let error {
            print("Failed", error)
        }
        contacts = contacts.sorted {
            $0.firstName < $1.firstName
        }
        print("222222222222")
        checkCOntacts(contacts: contacts)
        print("333333333333")
        
        return contacts
    }
    
    func checkCOntacts(contacts: [ContactInfo]) {
        
//        Auth.auth().
        
        for contact in contacts {
            print(contact)
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
