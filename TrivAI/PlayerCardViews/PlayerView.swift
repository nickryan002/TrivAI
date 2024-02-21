//
//  PlayerView.swift
//  TrivAI
//
//  Created by Nick Ryan on 1/10/24.
//

import SwiftUI

struct PlayerView: View {
    var name: String
    
    @State var score: Int = 0
    
    var body: some View {
        VStack {
            Text(name)
                .padding(.vertical, 10.0)
            HStack {
                Button(action: {
                    score -= 1
                }) {
                    Image(systemName: "minus")
                        .padding(.horizontal)
                }
                Text("\(score)")
                    .padding(.vertical, 12.0)
                Button(action: {
                    score += 1
                }) {
                    Image(systemName: "plus")
                        .padding(.horizontal)
                }
            }

        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.playerCardGreen, .appGreen]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(17)
        .padding(.bottom)
        
    }
}

#Preview {
    PlayerView(name: "Nick")
}
