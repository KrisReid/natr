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
                                            .animation(.easeOut(duration: 0.5), value: 1)
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
        
        let sampleArray = [User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []),User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: []), User(id: "", name: "", mobileNumber: "", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq7hpymOWO_E84SUM-9Bvrgz_JriPQl1vaCQ&usqp=CAU", fcmToken: "", publicToken: "", groups: [], favourites: [])
        ]
        
        
        FavouriteCarouselView(favourites: sampleArray )
        FavouriteCarouselView(favourites: sampleArray)
            .colorScheme(.dark)
            .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
    }
}
