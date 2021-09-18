//
//  Verification.swift
//  natr
//
//  Created by Kris Reid on 02/08/2021.
//

import SwiftUI

struct VerificationView: View {
    
    @ObservedObject var loginVM : LoginViewModel
    
    @Environment(\.presentationMode) var present
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isMoving: Bool = false
    
    
    var body: some View {
        
        ZStack (alignment: .topLeading) {
            
            Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                .ignoresSafeArea()
            
            HStack {
                Button(action: {present.wrappedValue.dismiss()}) {
                    Image(systemName: "arrow.left.circle")
                        .font(.title)
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                }
                if loginVM.loading{ProgressView()}
            }
            .padding()
            
            VStack {
                
                ZStack {
                    Image("iPhone_dark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding()
                    
                    Image(colorScheme == .dark ? "natr_sms_dark" : "natr_sms")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        .onAppear() {
                            self.isMoving.toggle()
                        }
                        .offset(x: 0, y: self.isMoving ? 0 - 80 : -UIScreen.main.bounds.height - 120)
                        .animation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 10, initialVelocity: 0), value: 1)
                }

                Text("Code sent to + \(loginVM.getCountryCode()) \(loginVM.mobileNumber)")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                    .padding(.bottom)
                
                TextField("Code", text: $loginVM.code)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(Color("Secondary_Foreground_Color"))
                    .background(Color("Secondary_Background_Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                Button(action: loginVM.verifyCode, label: {
                    Text("Verify")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                })
                .foregroundColor(Color("Primary_Foreground_Color"))
                .background(Color("Primary_Background_Color"))
                .cornerRadius(10)
                .padding()
            }
            
            if loginVM.error{
                AlertView(msg: loginVM.errorMsg, show: $loginVM.error)
            }
            
            if loginVM.loading {
                IndicatorView()
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $loginVM.accountCreation) {
            AccountCreationView(loginVM: loginVM)
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
    }
    
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(loginVM: .init())
        VerificationView(loginVM: .init())
            .colorScheme(.dark)
    }
}
