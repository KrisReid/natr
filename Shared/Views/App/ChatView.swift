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

    @State private var height: CGFloat = .zero
    @State var typingMessage: String = ""
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
                        }
                        .onAppear(perform: {
                            value.scrollTo(vm.messages.last?.id, anchor: .bottom)
                        })
                    }
                }
                .padding(.horizontal)
//                .padding(.bottom, keyboard.currentHeight == 0.0 ? 0 : 5)
                
                Spacer()

                HStack {
                    
                    List {
                        ZStack(alignment: .leading) {
                            Text(typingMessage).foregroundColor(.clear).padding(6)
                                .background(GeometryReader {
                                    Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                                })
                            TextEditor(text: $typingMessage)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(#colorLiteral(red: 0.8078074455, green: 0.8181154728, blue: 0.8177809715, alpha: 1)), lineWidth: 1)
                                )
                        }
                        .frame(maxHeight: 100)
                        .onPreferenceChange(ViewHeightKey.self) { height = $0 }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .onAppear {
                        UITableView.appearance().isScrollEnabled = false
                    }
                    .frame(minHeight: 44, idealHeight: height == 0 ? 44 : height, maxHeight: 100)

                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 6)
                            .foregroundColor(typingMessage == "" ? Color.gray : Color(#colorLiteral(red: 0.9741148353, green: 0.5559167266, blue: 0.504724443, alpha: 1)))
                    }
                    .disabled(typingMessage == "" ? true : false)
                }
                .frame(height: height)
                .padding()
                .padding(.bottom, keyboard.currentHeight == 0.0 ? 40 : keyboard.currentHeight)
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                
            }
            .navigationBarTitle(Text(chat.reciever.name), displayMode: .inline)
            .ignoresSafeArea(.all, edges: .bottom)
            .ignoresSafeArea(.keyboard, edges: .bottom)
//            .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading : .bottom)
            .onTapGesture {
                self.endEditing(true)
            }
        }
    }

    func sendMessage() {
        vm.postMessage(content: typingMessage, userId: currentUser.id, groupId: chat.groupId, fcmToken: chat.reciever.fcmToken, senderName: currentUser.name)
        typingMessage = ""
        hideKeyboard()
    }
    
}


struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(chat: Chat(reciever: User(id: "1GZDkkomqobMPhpaqUirtClFHLq1", name: "Alison MB", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", fcmToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey"), currentUser: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", fcmToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), vm: .init(groupId: "eUMO0EvYTXwqSon9Ppze"))
        
        ChatView(chat: Chat(reciever: User(id: "1GZDkkomqobMPhpaqUirtClFHLq1", name: "Alison MB", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", fcmToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey"), currentUser: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", fcmToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), vm: .init(groupId: "eUMO0EvYTXwqSon9Ppze"))
            .colorScheme(.dark)
        
        
    }
}
