//
//  MessageView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import SDWebImageSwiftUI

struct MessageView : View {
    
    var currentMessage: Message
    var imageUrl: String
    var isCurrentUser: Bool
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 15) {
            
            if !isCurrentUser {
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                    
            } else {
                Spacer()
            }
            
            ContentMessageView(contentMessage: currentMessage.content, isCurrentUser: isCurrentUser)
            
            if !isCurrentUser {
                Spacer()
            }
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        
        MessageView(currentMessage: Message(id: "999999", content: "Hello 😍", userId: "1GZDkkomqobMPhpaqUirtClFHLq1", timeDate: Timestamp(date: Date())), imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", isCurrentUser: false)
        
    }
    
}
