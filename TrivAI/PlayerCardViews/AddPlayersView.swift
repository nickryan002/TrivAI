//
//  AddPlayersView.swift
//  TrivAI
//
//  Created by Nick Ryan on 1/23/24.
//

import SwiftUI

struct AddPlayersView: View {
    @Binding var numPlayers: Int
    @Binding var playerNames: [Int : String]
    
    var body: some View {
        VStack {
            HStack {
                Text("Who's Playing?").padding()
                Button(action: {
                    if numPlayers < 4 {
                        numPlayers += 1
                        if playerNames[numPlayers] == nil {
                            playerNames[numPlayers] = "" // Initialize new player name
                        }
                    }
                }) {
                    Image(systemName: "plus")
                        .padding(.horizontal)
                }
                Button(action: {
                    if numPlayers > 1 {
                        playerNames.removeValue(forKey: numPlayers) // Remove last player name
                        numPlayers -= 1
                    }
                }) {
                    Image(systemName: "minus")
                        .padding(.horizontal)
                }
            }
            
            ForEach(1...numPlayers, id: \.self) { player in
                let binding = Binding<String>(get: {
                    self.playerNames[player, default: ""]
                }, set: {
                    self.playerNames[player] = $0
                })
                
                NewPlayerView(numPlayer: .constant(player), playerName: binding)
                
            }
        }
    }

    
    private func updatePlayerName(for player: Int, with name: String) {
        playerNames[player] = name
    }
}

#Preview {
    AddPlayersView(numPlayers: .constant(2), playerNames: .constant([1: "Nick", 2: "Jada"]))
}
