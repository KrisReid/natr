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
//    var OnOff: Bool
    @State var positionY: CGFloat = -300
    
    
    var body: some View {
        Capsule()
            .fill(Color(#colorLiteral(red: 0.9741148353, green: 0.5559167266, blue: 0.504724443, alpha: 1)))
            .frame(width: 3, height: height, alignment: .center)
//            .offset(y: OnOff ? positionY + 300 : positionY)
////            .offset(y: OnOff ? positionY : positionY + 300)
            .offset(y: positionY)
            .animation(.interpolatingSpring(mass: 1, stiffness: 10, damping: 4, initialVelocity: 5).delay(delay))
            .onAppear() {
//                if OnOff {
//                    positionY += offsetY - positionY - 300
//                } else {
////                    positionY = -300
//                    positionY += offsetY + positionY
//                }
                positionY += offsetY - positionY
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
        
//        HStack (spacing: 4) {
//            natrCapsule(height: 90, offsetY: 0, delay: 0, OnOff: false)
//            natrCapsule(height: 100, offsetY: 0, delay: 0.25, OnOff: false)
//            natrCapsule(height: 90, offsetY: 0, delay: 0.5, OnOff: false)
//            natrCapsule(height: 30, offsetY: -25, delay: 0.75, OnOff: false)
//            natrCapsule(height: 30, offsetY: -28, delay: 1, OnOff: true)
//            natrCapsule(height: 30, offsetY: -30, delay: 1.25, OnOff: true)
//            natrCapsule(height: 88, offsetY: 2, delay: 1.5, OnOff: true)
//            natrCapsule(height: 88, offsetY: 6, delay: 1.75, OnOff: true)
//            natrCapsule(height: 79, offsetY: 7, delay: 2, OnOff: true)
//        }
    }
}
