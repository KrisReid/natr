//
//  Drawing.swift
//  natr
//
//  Created by Kris Reid on 13/08/2021.
//

import SwiftUI


struct Blob: Shape {
    
    var offset: CGFloat
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: 30))
            path.addLine(to: CGPoint(x: rect.maxX, y: 30))
            path.addQuadCurve(to: CGPoint(x: -300, y: 30), control: CGPoint(x: 60, y: offset))
            path.addLine(to: CGPoint(x: rect.maxX, y: 30))
            path.addLine(to: CGPoint(x: rect.maxX, y: 200))
            path.addLine(to: CGPoint(x: rect.minX, y: 200))
        }
    }
}


struct Blob_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Blob(offset: -100)
                .fill(Color(#colorLiteral(red: 0.2614529133, green: 0.5135875344, blue: 0.5488628149, alpha: 1)))
                .frame(height: 200)
                .rotationEffect(.degrees(180))
        }
        
    }
}
