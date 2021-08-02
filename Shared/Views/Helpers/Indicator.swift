//
//  Indicator.swift
//  natr
//
//  Created by Kris Reid on 02/08/2021.
//

import SwiftUI

struct IndicatorView: View {
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                .ignoresSafeArea()
                .opacity(0.8)
            
            VStack {
                Indicator()
                Text("Currently Loading")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1)))
            .cornerRadius(8)
        }
        

    }
}


struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .white
        aiv.startAnimating()
        return aiv
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        //Do Nothing
    }
    
    typealias UIViewType = UIActivityIndicatorView
}

struct Indicator_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView()
    }
}
