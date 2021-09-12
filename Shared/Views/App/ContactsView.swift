//
//  SwiftUIView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import Contacts

struct ContactsView: View {
    
    @ObservedObject var vm = ContactsViewModel()
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(vm.mobileArray, id: \.self) { contact in
                    ContactRow(contact: contact)
                }
            }
        }
        .onAppear() {
            vm.requestAccess()
        }
    }
}


struct ContactRow: View {
    var contact: ContactInfo
    
    var body: some View {
        VStack {
            Text("\(contact.firstName) \(contact.lastName)")
                .foregroundColor(.primary)
            Text("\(contact.mobileNumber)")
                .foregroundColor(.secondary)
        }
    }
}


struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}

