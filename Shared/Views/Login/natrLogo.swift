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
            n(width: $width)
            a(width: $width)
            t(width: $width)
            r(width: $width)
        }
    }
}

struct n: View {
    
    @Binding var width: CGFloat
    
    var body: some View {
        HStack (spacing: 4) {
            Capsule()
                .frame(width: width, height: 90, alignment: .center)
            Capsule()
                .frame(width: width, height: 100, alignment: .center)
            Capsule()
                .frame(width: width, height: 90, alignment: .center)
            Capsule()
                .frame(width: width, height: 30, alignment: .center)
                .offset(x: 0, y: -25)
            Capsule()
                .frame(width: width, height: 30, alignment: .center)
                .offset(x: 0, y: -28)
            Capsule()
                .frame(width: width, height: 30, alignment: .center)
                .offset(x: 0, y: -30)
            Capsule()
                .frame(width: width, height: 88, alignment: .center)
                .offset(x: 0, y: 2)
            Capsule()
                .frame(width: width, height: 88, alignment: .center)
                .offset(x: 0, y: 6)
            Capsule()
                .frame(width: width, height: 79, alignment: .center)
                .offset(x: 0, y: 7)
        }
    }
}

struct a: View {
    
    @Binding var width: CGFloat
    
    var body: some View {
        HStack (spacing: 4) {
            Capsule()
                .frame(width: width, height: 24, alignment: .center)
                .offset(x: 0, y: 10)
            Capsule()
                .frame(width: width, height: 50, alignment: .center)
                .offset(x: 0, y: 10)
            Capsule()
                .frame(width: width, height: 70, alignment: .center)
                .offset(x: 0, y: 10)
            VStack {
                Capsule()
                    .frame(width: width, height: 30, alignment: .center)
                    .offset(x: 0, y: -2)
                Capsule()
                    .frame(width: width, height: 20, alignment: .center)
                    .offset(x: 0, y: 19)
            }
            VStack {
                Capsule()
                    .frame(width: width, height: 24, alignment: .center)
                    .offset(x: 0, y: -8)
                Capsule()
                    .frame(width: width, height: 20, alignment: .center)
                    .offset(x: 0, y: 24)
            }
            VStack {
                Capsule()
                    .frame(width: width, height: 24, alignment: .center)
                    .offset(x: 0, y: -8)
                Capsule()
                    .frame(width: width, height: 24, alignment: .center)
                    .offset(x: 0, y: 22)
            }
            VStack {
                Capsule()
                    .frame(width: width, height: 24, alignment: .center)
                    .offset(x: 0, y: -4)
                Capsule()
                    .frame(width: width, height: 24, alignment: .center)
                    .offset(x: 0, y: 18)
            }
            Capsule()
                .frame(width: width, height: 78, alignment: .center)
                .offset(x: 0, y: 6)
            Capsule()
                .frame(width: width, height: 78, alignment: .center)
                .offset(x: 0, y: 10)
            Capsule()
                .frame(width: width, height: 24, alignment: .center)
                .offset(x: 0, y: 36)
        }
    }
}


struct t: View {
    
    @Binding var width: CGFloat
    
    var body: some View {
        HStack (spacing: 4) {
            Capsule()
                .frame(width: width, height: 18, alignment: .center)
                .offset(x: 0, y: -20)
            Capsule()
                .frame(width: width, height: 20, alignment: .center)
                .offset(x: 0, y: -19)
            Capsule()
                .frame(width: width, height: 98, alignment: .center)
                .offset(x: 0, y: -10)
            Capsule()
                .frame(width: width, height: 120, alignment: .center)
                .offset(x: 0, y: -10)
            Capsule()
                .frame(width: width, height: 120, alignment: .center)
                .offset(x: 0, y: -10)
            Capsule()
                .frame(width: width, height: 98, alignment: .center)
                .offset(x: 0, y: -10)
            Capsule()
                .frame(width: width, height: 20, alignment: .center)
                .offset(x: 0, y: -19)
            Capsule()
                .frame(width: width, height: 18, alignment: .center)
                .offset(x: 0, y: -20)
            Capsule()
                .frame(width: width, height: 8, alignment: .center)
                .offset(x: 0, y: -20)
        }
    }
}

struct r: View {
    
    @Binding var width: CGFloat
    
    var body: some View {
        HStack (spacing: 4) {
            Capsule()
                .frame(width: width, height: 18, alignment: .center)
                .offset(x: 0, y: -14)
            Capsule()
                .frame(width: width, height: 76, alignment: .center)
                .offset(x: 0, y: 10)
            Capsule()
                .frame(width: width, height: 78, alignment: .center)
                .offset(x: 0, y: 12)
            Capsule()
                .frame(width: width, height: 72, alignment: .center)
                .offset(x: 0, y: 12)
            Capsule()
                .frame(width: width, height: 24, alignment: .center)
                .offset(x: 0, y: -14)
            Capsule()
                .frame(width: width, height: 20, alignment: .center)
                .offset(x: 0, y: -18)
            Capsule()
                .frame(width: width, height: 20, alignment: .center)
                .offset(x: 0, y: -20)
            Capsule()
                .frame(width: width, height: 24, alignment: .center)
                .offset(x: 0, y: -18)
            Capsule()
                .frame(width: width, height: 24, alignment: .center)
                .offset(x: 0, y: -14)
            Capsule()
                .frame(width: width, height: 14, alignment: .center)
                .offset(x: 0, y: -14)
        }
    }
}

struct natrLogo_Previews: PreviewProvider {
    static var previews: some View {
        natrLogo()
    }
}
