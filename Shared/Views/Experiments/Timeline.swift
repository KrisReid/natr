//
//  Timeline.swift
//  Timeline
//
//  Created by Kris Reid on 16/09/2021.
//

import SwiftUI

struct Timeline: View {
    static let emoji = ["😀", "😬", "😄", "🙂", "😗", "🤓", "😏", "😕", "😟", "😎", "😜", "😍", "🤪"]
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.2)) { timeline in

            HStack(spacing: 120) {

                let randomEmoji = Timeline.emoji.randomElement() ?? ""
            
                Text(randomEmoji)
                    .font(.largeTitle)
                    .scaleEffect(4.0)
                
                SubView()
                
            }
        }
    }
    
    struct SubView: View {
        var body: some View {
            let randomEmoji = Timeline.emoji.randomElement() ?? ""

            Text(randomEmoji)
                .font(.largeTitle)
                .scaleEffect(4.0)
        }
    }
}

struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
    }
}
