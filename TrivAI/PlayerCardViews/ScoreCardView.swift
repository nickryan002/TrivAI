//
//  ScoreCardView.swift
//  TrivAI
//
//  Created by Nick Ryan on 1/4/24.
//

import SwiftUI

struct ScoreCardView: View {
    @Binding var numPlayers: Int
    @Binding var playerNames: [Int : String]
    
    let scoreToWin: Int = 10
    
    var body: some View {
        
        VStack {
            Text("LeaderBoard").font(Font.custom("Aquire", size: 30))
            VStack {
                
                 let columns = [GridItem(.flexible()), GridItem(.flexible())]
                

                LazyVGrid(columns: columns) {
                    ForEach(1...numPlayers, id: \.self) { player in
                        if let playerName = playerNames[player] {
                            PlayerView(name: playerName)
                        }
                    }
                }
                
            }.padding()
        }
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    ScoreCardView(numPlayers: .constant(3), playerNames: .constant([1 : "Nick", 2: "Jada"]))
}
