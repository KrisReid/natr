//
//  LoginView.swift
//  natr
//
//  Created by Kris Reid on 02/08/2021.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @ObservedObject var loginVM = LoginViewModel()
    
    private let animation = Animation.easeInOut(duration: 20.0).repeatForever(autoreverses: true)
    @State private var change = false
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                .ignoresSafeArea()
            
            VStack {
                Blob(offset: change ? -200 : -100)
                    .fill(Color(#colorLiteral(red: 0.9696754813, green: 0.5562316775, blue: 0.5004004836, alpha: 1)))
                    .frame(height: 200)
                    .rotationEffect(.degrees(180))
                    .onAppear {
                        withAnimation (self.animation) {
                            change.toggle()
                        }
                    }
                
                Spacer()
            }
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                Spacer()
                
                
                Text("Welcome to Natr")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                    .padding(.top, 50)
                
                Spacer()
                
                HStack{
                    
                    Text("+ \(loginVM.getCountryCode())")
                        .frame(width: 45)
                        .padding()
                        .foregroundColor(Color("TextField_Text_Color"))
                        .background(Color("TextField_Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    TextField("Number", text: $loginVM.mobileNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .foregroundColor(Color("TextField_Text_Color"))
                        .background(Color("TextField_Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 15)
                
                
                NavigationLink(destination: VerificationView(loginVM: loginVM),isActive: $loginVM.gotoVerify) {
                    
                    Button(action: loginVM.sendCode, label: {
                        Text("Continue")
                            .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                    })
                    .foregroundColor(Color("Button_Text_Color"))
                    .background(Color("Button_Background_Color"))
                    .cornerRadius(10)
                    .padding(.top, 20)
                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)

            .padding()
            
            if loginVM.loading {
                IndicatorView()
            }
            
            if loginVM.error{
                AlertView(msg: loginVM.errorMsg, show: $loginVM.error)
            }
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        LoginView()
            .colorScheme(.dark)
    }
}
