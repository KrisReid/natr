//
//  KeyboardTesting.swift
//  natr
//
//  Created by Kris Reid on 03/09/2021.
//

import SwiftUI

struct KeyboardTesting: View {
    
    @State var text = ""
    //Auto updating the textbox height
    @State var containerHeight: CGFloat = 0
    
    var body: some View {
        
        HStack {
            VStack {
                AutoSizingTF(hint: "Enter Message", text: $text, containerHeight: $containerHeight, onEnd: {
                    //Do when keyboard closes
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                .padding(.horizontal)
                .frame(height: containerHeight <= 120 ? containerHeight : 120)
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(#colorLiteral(red: 0.8078074455, green: 0.8181154728, blue: 0.8177809715, alpha: 1)), lineWidth: 1)
                )
                .padding()
            }
            .padding(.vertical)
            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
            
            
            Button(action: sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 6)
//                    .foregroundColor(typingMessage == "" ? Color.gray : Color(#colorLiteral(red: 0.9741148353, green: 0.5559167266, blue: 0.504724443, alpha: 1)))
            }
//            .disabled(typingMessage == "" ? true : false)

        }
            
    }
    
    func sendMessage() {
        vm.postMessage(content: typingMessage, userId: currentUser.id, groupId: chat.groupId, fcmToken: chat.reciever.fcmToken, senderName: currentUser.name)
        typingMessage = ""
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
        textView.font = .systemFont(ofSize: 20)
        
        //setting the delegate
        textView.delegate = context.coordinator
        
        //Input accessory view
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.closeKeyBoard))
        
        toolBar.items = [spacer, doneButton]
        toolBar.sizeToFit()
        
        textView.inputAccessoryView = toolBar
        
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
            if textView.text == "" {
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
    }
}


struct KeyboardTesting_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardTesting()
    }
}
