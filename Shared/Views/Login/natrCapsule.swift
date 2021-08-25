//
//  natrCapsule.swift
//  natr
//
//  Created by Kris Reid on 20/08/2021.
//

import SwiftUI

struct natrCapsule: View {
    
    var height: CGFloat
    var offsetY: CGFloat
    var delay: Double
    
    @State var positionY = -300
//    @State var positionY = 0
    
    var body: some View {
        Capsule()
            .fill(Color(#colorLiteral(red: 0.9741148353, green: 0.5559167266, blue: 0.504724443, alpha: 1)))
            .frame(width: 3, height: height, alignment: .center)
            .offset(y: CGFloat(positionY))
            .animation(.interpolatingSpring(mass: 1, stiffness: 10, damping: 4, initialVelocity: 5).delay(delay))
            .onAppear() {
                positionY += Int(offsetY + 250)
//                positionY += Int(offsetY)
            }
    }
}

struct natrCapsule_Previews: PreviewProvider {
    static var previews: some View {
        
        HStack (spacing: 4) {
            natrCapsule(height: 90, offsetY: 0, delay: 0)
            natrCapsule(height: 100, offsetY: 0, delay: 0.25)
            natrCapsule(height: 90, offsetY: 0, delay: 0.5)
            natrCapsule(height: 30, offsetY: -25, delay: 0.75)
            natrCapsule(height: 30, offsetY: -28, delay: 1)
            natrCapsule(height: 30, offsetY: -30, delay: 1.25)
            natrCapsule(height: 88, offsetY: 2, delay: 1.5)
            natrCapsule(height: 88, offsetY: 6, delay: 1.75)
            natrCapsule(height: 79, offsetY: 7, delay: 2)
        }
    }
}
