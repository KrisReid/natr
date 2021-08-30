//
//  Dynamic.swift
//  natr
//
//  Created by Kris Reid on 30/08/2021.
//

import SwiftUI

struct Dynamic: View {
    
//    @State var text: String = "test"
//
//    @State private var height: CGFloat = .zero
    
    var body: some View {
        
        Text("Helloooo")
        
//        List {
//            ZStack(alignment: .leading) {
//                Text(text).foregroundColor(.clear).padding(6)
//                    .background(GeometryReader {
//                        Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
//                    })
//                TextEditor(text: $text)
//                    .frame(minHeight: height)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 6)
//                            .stroke(Color(#colorLiteral(red: 0.8078074455, green: 0.8181154728, blue: 0.8177809715, alpha: 1)), lineWidth: 1)
//                    )
//            }
//            .onPreferenceChange(ViewHeightKey.self) { height = $0 }
//            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//        }
    }
}

//struct ViewHeightKey: PreferenceKey {
//    static var defaultValue: CGFloat { 0 }
//    static func reduce(value: inout Value, nextValue: () -> Value) {
//        value = value + nextValue()
//    }
//}

    

struct Dynamic_Previews: PreviewProvider {
    static var previews: some View {
        Dynamic()
    }
}






//                    TextEditor(text: $typingMessage)
//                        .frame(width: geometry.size.width * 0.8, height: 50)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 6)
//                                .stroke(Color(#colorLiteral(red: 0.8078074455, green: 0.8181154728, blue: 0.8177809715, alpha: 1)), lineWidth: 1)
//                        )
