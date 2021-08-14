//
//  MoreDrawing.swift
//  natr
//
//  Created by Kris Reid on 13/08/2021.
//

import SwiftUI

struct MoreDrawing: View {
        
    private let animation = Animation.easeInOut(duration: 2.5).repeatForever(autoreverses: true)
    
    @State private var change = false
    private let arrowWidth: CGFloat = 80
    
    
    var body: some View {
        MyArrow(width: arrowWidth, offset: change ? -20 : 20)
        .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
        .frame(width: arrowWidth)
        .foregroundColor(.green)
        .padding(.top, 100)
        .onAppear {
            withAnimation (self.animation) {
                change.toggle()
            }
        }
    }
}


struct MyArrow: Shape {
    var width: CGFloat
    var offset: CGFloat
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: width/2, y: offset))
            path.move(to: CGPoint(x: width/2, y: offset))
            path.addLine(to: CGPoint(x: width, y: 0))
        }
    }
}




struct MoreDrawing_Previews: PreviewProvider {
    static var previews: some View {
        MoreDrawing()
    }
}

