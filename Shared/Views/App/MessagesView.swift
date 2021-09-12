//
//  MessagesView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MessagesView: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0)))
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))]
        UITableView.appearance().backgroundColor = UIColor(Color("Primary_Background_Color"))
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    @State private var showModal:Bool = false
    @ObservedObject var vm = MessagesViewModel()
    
    
    var body: some View {
        
        NavigationView {
            ZStack (alignment: .topLeading) {
                Color("Primary_Background_Color")
                    .ignoresSafeArea()
                

                VStack (alignment: .leading, spacing: 20) {
                    
                    FavouriteCarouselView(favourites: vm.favourites)
                        .padding(.top, 10)
                    
                    SearchView(searchTerm: self.$vm.searchTerm)
                        .padding()
                    
                    MessageListView(chats: vm.chats, currentUser: vm.currentUser)

                }
                
            }
            .navigationBarTitle("Messages")
            .navigationBarItems(trailing: Button(action: showContactList, label: {
                Image(systemName: "plus")
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .font(.system(size: 26, weight: .light))
            }))
            .sheet(isPresented: $showModal) {
                ContactsView(mobielNumber: $vm.currentUser.mobileNumber, isPresented: self.$showModal)
            }
        }
    }
    
    private func showContactList() {
        self.showModal = true
    }
    
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
        MessagesView()
            .colorScheme(.dark)
    }
}
