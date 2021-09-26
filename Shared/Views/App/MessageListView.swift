//
//  MessageListView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI


struct MessageListView: View {
    
    var chats: [Chat]
    var currentUser: User
        
    var body: some View {
    
        List {
            ForEach(self.chats, id: \.self) { chat in
                NavigationLink (
                    destination: ChatView(chat: chat, currentUser: self.currentUser, vm: .init(groupId: chat.groupId, recipientPublicToken: chat.reciever.publicToken, usersPublicToken: currentUser.publicToken)),
                    label: {
                        MessageCellView(message: chat)
                            .foregroundColor(Color(.label))
                    }
                )
            }
            .listRowBackground(Color("Primary_Background_Color"))
        }
        .listStyle(PlainListStyle())
    }
}


struct MessageCellView: View {
    
    let message: Chat
    
    var body: some View {
        
        HStack (alignment: .top) {
            
            WebImage(url: URL(string: message.reciever.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64, alignment: .center)
                .overlay(Circle().stroke(lineWidth: 0.5))
                .cornerRadius(32)
            
            VStack (alignment: .leading){
                Text(message.reciever.name)
                    .font(.system(size: 16, weight: .regular))
                Text(message.lastMessage)
                    .font(.system(size: 16, weight: .light))
                    .padding(.top, 1)
            }

        }
    }
}
    
    

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        
        //Fetch the API Key
        let fcmToken = (Bundle.main.infoDictionary?["TEST_FCM_TOKEN"] as? String)!
        
        MessageListView(chats: [Chat(reciever: User(id: "v1IiXJdJe7Ww1GHIKMEePocoxYs2", name: "Alison Bell", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fv1IiXJdJe7Ww1GHIKMEePocoxYs2.jpeg?alt=media&token=2e61469b-3ac5-4c9d-8b85-625f1e985010", fcmToken: fcmToken, publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey")], currentUser: User(id: "1234", name: "Kris", mobileNumber: "+447432426798", imageUrl: "Sandra", fcmToken: "123456778", publicToken: "", groups: [""], favourites: [""]))
        
        MessageListView(chats: [Chat(reciever: User(id: "v1IiXJdJe7Ww1GHIKMEePocoxYs2", name: "Alison Bell", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fv1IiXJdJe7Ww1GHIKMEePocoxYs2.jpeg?alt=media&token=2e61469b-3ac5-4c9d-8b85-625f1e985010", fcmToken: fcmToken, publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey")], currentUser: User(id: "1234", name: "Kris", mobileNumber: "+447432426798", imageUrl: "Sandra", fcmToken: "123456778", publicToken: "", groups: [""], favourites: [""]))
            .colorScheme(.dark)
        
    }
}
