//
//  AccountCreationView.swift
//  natr
//
//  Created by Kris Reid on 02/08/2021.
//

import SwiftUI

struct AccountCreationView: View {
        
    @ObservedObject var loginVM : LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var showingImagePicker: Bool = false
    @State var image: Image?
    
    var body: some View {
        
        ZStack (alignment: .topLeading) {
            
            Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding()
                    } else {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(Color("Secondary_Background_Color"))
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .padding()
                            .font(.system(size: 1, weight: .ultraLight))
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                
                TextField("Name", text: $loginVM.name)
                    .keyboardType(.default)
                    .padding()
                    .background(Color("Secondary_Background_Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                
                Button(action: {
                    loginVM.CreateUser()
                }) {
                    Text("Create an account")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                }
                .foregroundColor(Color("Primary_Foreground_Color"))
                .background(Color("Primary_Background_Color"))
                .cornerRadius(10)
                
            }
            
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $loginVM.inputImage)
                
            }
            
            if loginVM.error{
                AlertView(msg: loginVM.errorMsg, show: $loginVM.error)
            }
            
            if loginVM.loading {
                IndicatorView()
            }
            
        }
        
    }
    
    func loadImage() {
        guard let inputImage = loginVM.inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct AccountCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreationView(loginVM: .init())
        AccountCreationView(loginVM: .init())
            .colorScheme(.dark)
    }
}
