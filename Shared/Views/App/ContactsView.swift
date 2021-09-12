//
//  SwiftUIView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import Contacts

struct ContactsView: View {
    
    @Binding var mobielNumber: String
    @Binding var isPresented: Bool
    
    @ObservedObject var vm = ContactsViewModel()
    
    var body: some View {
        ZStack {
            Color("Primary_Background_Color")
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text("Contacts")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                    .padding()
                    .padding(.top, 20)
                
                List {
                    ForEach(vm.mobileArray, id: \.self) { contact in
                        ContactRow(contact: contact)
                    }
                    .listRowBackground(Color("Primary_Background_Color"))
                }
                .listStyle(PlainListStyle())
            }
            .onAppear() {
                vm.mobileNumber = mobielNumber
                vm.requestAccess()
            }
        }
    }
}


struct ContactRow: View {
    var contact: ContactInfo
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("\(contact.firstName) \(contact.lastName)")
                    .foregroundColor(.primary)
                Text("\(contact.mobileNumber)")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                // Go back to the other page
                // Create a new chat with these 2 users
            }, label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 26, weight: .light))
            })
        }
    }
}


struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(mobielNumber: .constant(""), isPresented: .constant(false))
    }
}

