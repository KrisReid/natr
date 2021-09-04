//
//  natrLogo.swift
//  natr
//
//  Created by Kris Reid on 20/08/2021.
//

import SwiftUI

struct natrLogo: View {
    
    @State var width: CGFloat = 3
//    let onOff: Bool = false
//    let onOff: Bool

    
    var body: some View {

        HStack (spacing: 14) {
            n()
            a()
            t()
            r()
//            n(onOff: onOff)
//            a(onOff: onOff)
//            t(onOff: onOff)
//            r(onOff: onOff)
        }
    }
}


//struct n: View {
//
//    let onOff: Bool
//
//    var body: some View {
//        HStack (spacing: 4) {
//            natrCapsule(height: 90, offsetY: 0, delay: 0, OnOff: onOff)
//            natrCapsule(height: 100, offsetY: 0, delay: 0.1, OnOff: onOff)
//            natrCapsule(height: 90, offsetY: 0, delay: 0.2, OnOff: onOff)
//            natrCapsule(height: 30, offsetY: -25, delay: 0.3, OnOff: onOff)
//            natrCapsule(height: 30, offsetY: -28, delay: 0.4, OnOff: onOff)
//            natrCapsule(height: 30, offsetY: -30, delay: 0.5, OnOff: onOff)
//            natrCapsule(height: 88, offsetY: 2, delay: 0.6, OnOff: onOff)
//            natrCapsule(height: 88, offsetY: 6, delay: 0.7, OnOff: onOff)
//            natrCapsule(height: 79, offsetY: 7, delay: 0.8, OnOff: onOff)
//        }
//    }
//}
//
//
//struct a: View {
//
//    let onOff: Bool
//
//    var body: some View {
//        HStack (spacing: 4) {
//            natrCapsule(height: 24, offsetY: 10, delay: 1, OnOff: onOff)
//            natrCapsule(height: 50, offsetY: 10, delay: 1.2, OnOff: onOff)
//            natrCapsule(height: 70, offsetY: 10, delay: 1.3, OnOff: onOff)
//            VStack {
//                natrCapsule(height: 30, offsetY: -2, delay: 1.4, OnOff: onOff)
//                natrCapsule(height: 20, offsetY: 19, delay: 1.4, OnOff: onOff)
//            }
//            VStack {
//                natrCapsule(height: 24, offsetY: -8, delay: 1.5, OnOff: onOff)
//                natrCapsule(height: 20, offsetY: 24, delay: 1.5, OnOff: onOff)
//            }
//            VStack {
//                natrCapsule(height: 24, offsetY: -8, delay: 1.6, OnOff: onOff)
//                natrCapsule(height: 24, offsetY: 22, delay: 1.6, OnOff: onOff)
//            }
//            VStack {
//                natrCapsule(height: 24, offsetY: -4, delay: 1.7, OnOff: onOff)
//                natrCapsule(height: 24, offsetY: 18, delay: 1.7, OnOff: onOff)
//            }
//            natrCapsule(height: 78, offsetY: 6, delay: 1.8, OnOff: onOff)
//            natrCapsule(height: 78, offsetY: 10, delay: 1.9, OnOff: onOff)
//            natrCapsule(height: 24, offsetY: 36, delay: 2, OnOff: onOff)
//        }
//    }
//}
//
//struct t: View {
//
//    let onOff: Bool
//
//    var body: some View {
//        HStack (spacing: 4) {
//            natrCapsule(height: 18, offsetY: -20, delay: 2.1, OnOff: onOff)
//            natrCapsule(height: 20, offsetY: -19, delay: 2.2, OnOff: onOff)
//            natrCapsule(height: 98, offsetY: -10, delay: 2.3, OnOff: onOff)
//            natrCapsule(height: 120, offsetY: -10, delay: 2.4, OnOff: onOff)
//            natrCapsule(height: 120, offsetY: -10, delay: 2.5, OnOff: onOff)
//            natrCapsule(height: 98, offsetY: -10, delay: 2.6, OnOff: onOff)
//            natrCapsule(height: 28, offsetY: -19, delay: 2.7, OnOff: onOff)
//            natrCapsule(height: 18, offsetY: -20, delay: 2.8, OnOff: onOff)
//            natrCapsule(height: 8, offsetY: -20, delay: 2.9, OnOff: onOff)
//        }
//    }
//}
//
//struct r: View {
//
//    let onOff: Bool
//
//    var body: some View {
//        HStack (spacing: 4) {
//            natrCapsule(height: 18, offsetY: -14, delay: 3, OnOff: onOff)
//            natrCapsule(height: 76, offsetY: 10, delay: 3.1, OnOff: onOff)
//            natrCapsule(height: 78, offsetY: 12, delay: 3.2, OnOff: onOff)
//            natrCapsule(height: 72, offsetY: 12, delay: 3.3, OnOff: onOff)
//            natrCapsule(height: 24, offsetY: -14, delay: 3.4, OnOff: onOff)
//            natrCapsule(height: 20, offsetY: -18, delay: 3.5, OnOff: onOff)
//            natrCapsule(height: 20, offsetY: -20, delay: 3.6, OnOff: onOff)
//            natrCapsule(height: 24, offsetY: -18, delay: 3.7, OnOff: onOff)
//            natrCapsule(height: 24, offsetY: -14, delay: 3.8, OnOff: onOff)
//            natrCapsule(height: 14, offsetY: -14, delay: 3.9, OnOff: onOff)
//        }
//    }
//}


struct n: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 90, offsetY: 0, delay: 0)
            natrCapsule(height: 100, offsetY: 0, delay: 0.1)
            natrCapsule(height: 90, offsetY: 0, delay: 0.2)
            natrCapsule(height: 30, offsetY: -25, delay: 0.3)
            natrCapsule(height: 30, offsetY: -28, delay: 0.4)
            natrCapsule(height: 30, offsetY: -30, delay: 0.5)
            natrCapsule(height: 88, offsetY: 2, delay: 0.6)
            natrCapsule(height: 88, offsetY: 6, delay: 0.7)
            natrCapsule(height: 79, offsetY: 7, delay: 0.8)
        }
    }
}

struct a: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 24, offsetY: 10, delay: 1)
            natrCapsule(height: 50, offsetY: 10, delay: 1.2)
            natrCapsule(height: 70, offsetY: 10, delay: 1.3)
            VStack {
                natrCapsule(height: 30, offsetY: -2, delay: 1.4)
                natrCapsule(height: 20, offsetY: 19, delay: 1.4)
            }
            VStack {
                natrCapsule(height: 24, offsetY: -8, delay: 1.5)
                natrCapsule(height: 20, offsetY: 24, delay: 1.5)
            }
            VStack {
                natrCapsule(height: 24, offsetY: -8, delay: 1.6)
                natrCapsule(height: 24, offsetY: 22, delay: 1.6)
            }
            VStack {
                natrCapsule(height: 24, offsetY: -4, delay: 1.7)
                natrCapsule(height: 24, offsetY: 18, delay: 1.7)
            }
            natrCapsule(height: 78, offsetY: 6, delay: 1.8)
            natrCapsule(height: 78, offsetY: 10, delay: 1.9)
            natrCapsule(height: 24, offsetY: 36, delay: 2)
        }
    }
}

struct t: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 18, offsetY: -20, delay: 2.1)
            natrCapsule(height: 20, offsetY: -19, delay: 2.2)
            natrCapsule(height: 98, offsetY: -10, delay: 2.3)
            natrCapsule(height: 120, offsetY: -10, delay: 2.4)
            natrCapsule(height: 120, offsetY: -10, delay: 2.5)
            natrCapsule(height: 98, offsetY: -10, delay: 2.6)
            natrCapsule(height: 28, offsetY: -19, delay: 2.7)
            natrCapsule(height: 18, offsetY: -20, delay: 2.8)
            natrCapsule(height: 8, offsetY: -20, delay: 2.9)
        }
    }
}

struct r: View {
    var body: some View {
        HStack (spacing: 4) {
            natrCapsule(height: 18, offsetY: -14, delay: 3)
            natrCapsule(height: 76, offsetY: 10, delay: 3.1)
            natrCapsule(height: 78, offsetY: 12, delay: 3.2)
            natrCapsule(height: 72, offsetY: 12, delay: 3.3)
            natrCapsule(height: 24, offsetY: -14, delay: 3.4)
            natrCapsule(height: 20, offsetY: -18, delay: 3.5)
            natrCapsule(height: 20, offsetY: -20, delay: 3.6)
            natrCapsule(height: 24, offsetY: -18, delay: 3.7)
            natrCapsule(height: 24, offsetY: -14, delay: 3.8)
            natrCapsule(height: 14, offsetY: -14, delay: 3.9)
        }
    }
}


struct natrLogo_Previews: PreviewProvider {
    static var previews: some View {
//        natrLogo(onOff: true)
        natrLogo()
    }
}
