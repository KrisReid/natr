//
//  ChatView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ChatView: View {
    
    let chat: Chat
    let currentUser: User

    @ObservedObject private var keyboard = KeyboardResponder()
    @ObservedObject var vm: ChatViewModel
    
    var body: some View {
        
        GeometryReader { geometry in

            Color("Secondary_Background_Color")
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    ScrollViewReader { value in
                        
                        Button("") {
                            value.scrollTo(vm.messages.last?.id, anchor: .bottom)
                        }
                        
                        ForEach(vm.messages, id: \.self) { message in
                            MessageView(currentMessage: message, imageUrl: chat.reciever.imageUrl, isCurrentUser: message.userId == currentUser.id ? true : false)
                                .id(message.id)
//                            MessageView(currentMessage: message, imageUrl: chat.reciever.imageUrl, isCurrentUser: message.userId == currentUser.id ? true : false, publicToken: chat.reciever.publicToken)
//                                .id(message.id)
                        }
                        .onAppear(perform: {
                            value.scrollTo(vm.messages.last?.id, anchor: .bottom)
                        })
                    }
                }
                .padding(.horizontal)
                                
                Spacer()
                    
                TextBox(vm: vm, chat: chat, currentUser: currentUser)
                
            }
            .offset(x: 0, y: keyboard.currentHeight == 0.0 ? 0 : -keyboard.currentHeight)
            .navigationBarTitle(Text(chat.reciever.name), displayMode: .inline)
            .ignoresSafeArea(.all, edges: .bottom)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onTapGesture {
                self.endEditing(true)
            }
        }
    }
    
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(chat: Chat(reciever: User(id: "1GZDkkomqobMPhpaqUirtClFHLq1", name: "Alison MB", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey"), currentUser: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), vm: .init(groupId: "eUMO0EvYTXwqSon9Ppze", recipientPublicToken: "", usersPublicToken: ""))
        
        ChatView(chat: Chat(reciever: User(id: "1GZDkkomqobMPhpaqUirtClFHLq1", name: "Alison MB", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey"), currentUser: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), vm: .init(groupId: "eUMO0EvYTXwqSon9Ppze", recipientPublicToken: "", usersPublicToken: ""))
            .colorScheme(.dark)
        
        
    }
}
