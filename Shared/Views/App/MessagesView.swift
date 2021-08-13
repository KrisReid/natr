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
        UINavigationBar.appearance().backgroundColor = UIColor(Color("Button_Background_Color"))
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))]
        UITableView.appearance().backgroundColor = UIColor(Color("Button_Background_Color"))
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    
    @ObservedObject var vm = MessagesViewModel()
    
    
    var body: some View {
        
        NavigationView {
            ZStack (alignment: .topLeading) {
                Color("Button_Background_Color")
                    .ignoresSafeArea()
                VStack (alignment: .leading, spacing: 20) {
                    
                    SearchView(searchTerm: self.$vm.searchTerm)
                        .padding()
                    
                    FavouriteCarouselView(favourites: vm.favourites)
                                        
                    //Figure out the correct data models we want to apply within the app
                    MessageListView(chats: vm.chats, currentUser: vm.currentUser)
                    
                    //Testing
//                    NavigationLink(
//                        destination: ContactsView(),
//                        label: {
//                            Text("Contacts")
//                        }
//                    )

                }
            }
            .navigationBarTitle("Messages")
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
        MessagesView()
            .colorScheme(.dark)
    }
}
