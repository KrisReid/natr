//
//  natrLogo.swift
//  natr
//
//  Created by Kris Reid on 20/08/2021.
//

import SwiftUI

struct natrLogo: View {
    
    @State var width: CGFloat = 3
    
    var body: some View {

        HStack (spacing: 14) {
            n()
            a()
            t()
            r()
        }
    }
}


struct n: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 90, offsetY: 0)
            natrCapsule(height: 100, offsetY: 0)
            natrCapsule(height: 90, offsetY: 0)
            natrCapsule(height: 30, offsetY: -25)
            natrCapsule(height: 30, offsetY: -28)
            natrCapsule(height: 30, offsetY: -30)
            natrCapsule(height: 88, offsetY: 2)
            natrCapsule(height: 88, offsetY: 6)
            natrCapsule(height: 79, offsetY: 7)
        }
    }
}

struct a: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 24, offsetY: 10)
            natrCapsule(height: 50, offsetY: 10)
            natrCapsule(height: 70, offsetY: 10)
            VStack {
                natrCapsule(height: 30, offsetY: -2)
                natrCapsule(height: 20, offsetY: 19)
            }
            VStack {
                natrCapsule(height: 24, offsetY: -8)
                natrCapsule(height: 20, offsetY: 24)
            }
            VStack {
                natrCapsule(height: 24, offsetY: -8)
                natrCapsule(height: 24, offsetY: 22)
            }
            VStack {
                natrCapsule(height: 24, offsetY: -4)
                natrCapsule(height: 24, offsetY: 18)
            }
            natrCapsule(height: 78, offsetY: 6)
            natrCapsule(height: 78, offsetY: 10)
            natrCapsule(height: 24, offsetY: 36)
        }
    }
}

struct t: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 18, offsetY: -20)
            natrCapsule(height: 20, offsetY: -19)
            natrCapsule(height: 98, offsetY: -10)
            natrCapsule(height: 120, offsetY: -10)
            natrCapsule(height: 120, offsetY: -10)
            natrCapsule(height: 98, offsetY: -10)
            natrCapsule(height: 28, offsetY: -19)
            natrCapsule(height: 18, offsetY: -20)
            natrCapsule(height: 8, offsetY: -20)
        }
    }
}

struct r: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 18, offsetY: -14)
            natrCapsule(height: 76, offsetY: 10)
            natrCapsule(height: 78, offsetY: 12)
            natrCapsule(height: 72, offsetY: 12)
            natrCapsule(height: 24, offsetY: -14)
            natrCapsule(height: 20, offsetY: -18)
            natrCapsule(height: 20, offsetY: -20)
            natrCapsule(height: 24, offsetY: -18)
            natrCapsule(height: 24, offsetY: -14)
            natrCapsule(height: 14, offsetY: -14)
        }
    }
}


struct natrLogo_Previews: PreviewProvider {
    static var previews: some View {
        natrLogo()
    }
}
