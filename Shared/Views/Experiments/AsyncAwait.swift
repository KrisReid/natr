//
//  AsyncAwait.swift
//  AsyncAwait
//
//  Created by Kris Reid on 14/09/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AsyncAwait: View {
    
    @Binding var isPresented: Bool
    @State var users: [User] = []
    @State var errorMsg: String = ""
    @State var showError = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users){ user in
                    HStack {
                        AsyncImage(url: URL(string: user.imageUrl)) {phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(12)
                            } else {
                                ProgressView()
                                    .frame(maxHeight: .infinity, alignment: .center)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(user.name)
                                .font(.title2.bold())
                        }
                    }
                }
            }
            .navigationTitle("ASync / await testing")
            .refreshable {
//                await fetchData()
                fetchData()
                
            }
        }
        .alert(errorMsg, isPresented: $showError) {
            Button("OK", role: .cancel) {
                
            }
        }
    }
    
    func fetchData() {
//        Crypto().deletePrivateKey()
    }
    
    
}

enum DataBaseError: String,Error {
    case failed = "Failed to fetch from Database"
}

enum AuthError: String,Error {
    case failedToLogin = "Failed to login"
}



struct AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait(isPresented: .constant(false))
    }
}
