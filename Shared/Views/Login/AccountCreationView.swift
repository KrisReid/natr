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
//                            .renderingMode(.original)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding()
                    } else {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(colorScheme == .dark ? Color(#colorLiteral(red: 0.1662652493, green: 0.1663002372, blue: 0.1662606299, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
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
                    .background(Color("TextField_Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                
                Button(action: {
                    loginVM.CreateUser()
                }) {
                    Text("Create an account")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                }
                .foregroundColor(Color("Button_Text_Color"))
                .background(Color("Button_Background_Color"))
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
