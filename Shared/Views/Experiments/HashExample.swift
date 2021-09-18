//
//  HashExample.swift
//  natr
//
//  Created by Kris Reid on 05/09/2021.
//

import SwiftUI

struct HashExample: View {
    
    @State var name: String = ""
    @ObservedObject var vm = HashingPOCHelper()
    
    var body: some View {
        VStack (alignment: .leading) {
            TextField("Enter username...", text: $name)
                .padding()
                .border(Color.black)
            
            
            Button(action: {
                vm.hashMeBaby(value: name)
//                vm.encryptData(encryptString: name)
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 6)
                Text("Hash me Baby !!!!!!!")
            }
            
//            Text("HASH: \(vm.hash)")
            
            
            
        }
        .padding()
    }
}

struct HashExample_Previews: PreviewProvider {
    static var previews: some View {
        HashExample()
    }
}
