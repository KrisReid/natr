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
    
    
    var body: some View {
        Capsule()
            .fill(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
            .frame(width: 3, height: height, alignment: .center)
            .offset(x: 0, y: offsetY)
        
    }
}

struct natrCapsule_Previews: PreviewProvider {
    static var previews: some View {
        natrCapsule(height: 100, offsetY: 0)
    }
}
