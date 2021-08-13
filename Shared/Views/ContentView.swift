//
//  ContentView.swift
//  Shared
//
//  Created by Kris Reid on 02/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        ZStack{
            if status{
                MessagesView()
            }
            else {
                NavigationView{
                    LoginView()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
