//
//  FavouriteCarouselView.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouriteCarouselView: View {
    
    var favourites: [User]
    
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        
        let diff = abs(x)
        if diff < 100 {
            scale = 1 + (100 - diff) / 600
        }
        
        return scale
    }
    
    var body: some View {
        VStack (spacing: 0) {
            ScrollView(.horizontal) {
                HStack (spacing: 40) {
//                    ForEach(0..<20, id: \.self)  { num in
                    ForEach(favourites, id: \.self)  { num in
                        GeometryReader { proxy in
                            NavigationLink(
                                destination: Image("Sandra"),
                                label: {
                                    VStack {
                                        let scale = getScale(proxy: proxy)
                                        
//                                        Image("Sandra")
                                        WebImage(url: URL(string: num.imageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 64, height: 64, alignment: .center)
                                            .overlay(Circle().stroke(lineWidth: 0.5))
                                            .clipped()
                                            .cornerRadius(32)
                                            .shadow(radius: 5)
                                            .scaleEffect(CGSize(width: scale, height: scale))
                                            .animation(.easeOut(duration: 0.5))
                                    }
                                }
                            )
                        }
                        .frame(width: 50, height: 70)
                    }
                }
                .padding(20)
            }
        }
    }
}

struct FavouriteCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        
        let sampleArray = [User(id: "", name: "", mobileNumber: "", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fxk8d0f0GnVQ42rU9behcW3lCX4N2.jpeg?alt=media&token=8368d3bd-e1cb-4761-9782-42282d4bb4c7", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fv1IiXJdJe7Ww1GHIKMEePocoxYs2.jpeg?alt=media&token=2e61469b-3ac5-4c9d-8b85-625f1e985010", fcmToken: "", publicToken: "", groups: [], favourites: [])]
        
        
        FavouriteCarouselView(favourites: sampleArray )
        FavouriteCarouselView(favourites: sampleArray)
            .colorScheme(.dark)
            .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
    }
}
