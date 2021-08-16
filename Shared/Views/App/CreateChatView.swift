//
//  CreateChatView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateChatView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var vm = CreateChatViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.9696754813, green: 0.5562316775, blue: 0.5004004836, alpha: 1))
                .ignoresSafeArea()
            
            VStack {
                
                Text("New Chat")
                    .font(.system(size: 20, weight: .bold))
                    .offset(y: 20)
                
                NavigationView {
                    List(vm.users) { user in
                        Button(action: {
                            self.isPresented.toggle()
                        }, label: {
                            UserCellView(user: user)
                        })
                    }
                    .navigationBarHidden(true)
                }
                .offset(y: 30)
            }
        }
    }
}

struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatView(isPresented: .constant(false))
    }
}


struct UserCellView: View {
    
    let user: User
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: user.imageUrl))
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(height: 50)
            
            VStack (alignment: .leading) {
                Text(user.name)
                    .font(.system(size: 16, weight: .regular))
                
                Text(user.mobileNumber)
                    .font(.system(size: 14, weight: .light))
            }
        }
    }
}
