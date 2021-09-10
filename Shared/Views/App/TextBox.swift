//
//  TextBox.swift
//  natr
//
//  Created by Kris Reid on 03/09/2021.
//

import SwiftUI

struct TextBox: View {
    
    @ObservedObject var vm: ChatViewModel
    let chat: Chat
    let currentUser: User
    
    @State var text: String = ""
    @State var containerHeight: CGFloat = 0
    
    var body: some View {
        
        HStack {
            VStack {
                AutoSizingTF(hint: "...", text: $text, containerHeight: $containerHeight, onEnd: {
                    //Do when keyboard closes
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                .padding(.horizontal, 6)
                .frame(height: containerHeight <= 120 ? containerHeight : 120)
                .background(Color("Tertiary_Foreground_Color"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(#colorLiteral(red: 0.8078074455, green: 0.8181154728, blue: 0.8177809715, alpha: 1)), lineWidth: 1)
                )
            }
            .padding(.bottom, 10)
            
            Button(action: sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 6)
                    .foregroundColor(text == "" ? Color.gray : Color(#colorLiteral(red: 0.9741148353, green: 0.5559167266, blue: 0.504724443, alpha: 1)))
            }
            .disabled(text == "" ? true : false)
        }
        .padding()
        .background(Color("Tertiary_Background_Color"))
    }
    
    func sendMessage() {
        vm.postMessage(content: text, userId: currentUser.id, groupId: chat.groupId, fcmToken: chat.reciever.fcmToken, senderName: currentUser.name)
        text = ""
        hideKeyboard()
    }
}

struct AutoSizingTF: UIViewRepresentable {
    
    var hint: String
    @Binding var text: String
    @Binding var containerHeight: CGFloat
    var onEnd: ()->()
    
    func makeCoordinator() -> Coordinator {
        return AutoSizingTF.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        //display the text as hint
        textView.text = hint
        textView.textColor = .darkGray
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16)
        
        //setting the delegate
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView (_ uiView: UITextView, context: Context) {
        //Starting TextField Height
        DispatchQueue.main.async {
            if containerHeight == 0 {
                containerHeight = uiView.contentSize.height
            }
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        //Read the parent properties
        
        var parent: AutoSizingTF
        
        init(parent: AutoSizingTF) {
            self.parent = parent
        }
        
        //Keyboard closing function
        @objc func closeKeyBoard() {
            parent.onEnd()
        }
        
        //Checking if text box is empty and clearing the hint
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.hint {
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        
        //Updating the text in SwiftUI View
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.containerHeight = textView.contentSize.height
        }
        
        //if textbox is empty then use hint
        func textViewDidEndEditing(_ textView: UITextView) {
            
            //clear the parent text field first
            if parent.text == "" {
                textView.text = ""
                parent.containerHeight = 0
            }
            
            if textView.text == "" {
                textView.text = parent.hint
                textView.textColor = .darkGray
            }
        }
        
    }
}


struct TextBox_Previews: PreviewProvider {
    static var previews: some View {
        
        TextBox(vm: .init(groupId: "eUMO0EvYTXwqSon9Ppze"), chat: Chat(reciever: User(id: "1GZDkkomqobMPhpaqUirtClFHLq1", name: "Alison MB", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey"), currentUser: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]))
        
        TextBox(vm: .init(groupId: "eUMO0EvYTXwqSon9Ppze"), chat: Chat(reciever: User(id: "1GZDkkomqobMPhpaqUirtClFHLq1", name: "Alison MB", mobileNumber: "+447515509832", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]), groupId: "eUMO0EvYTXwqSon9Ppze", lastMessage: "Hey"), currentUser: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", fcmToken: "", publicToken: "", groups: ["eUMO0EvYTXwqSon9Ppze"], favourites: [""]))
            .colorScheme(.dark)

    }
}
