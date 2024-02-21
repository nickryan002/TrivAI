//
//  NewPlayerView.swift
//  TrivAI
//
//  Created by Nick Ryan on 1/24/24.
//

import SwiftUI

struct NewPlayerView: View {
    @Binding var numPlayer: Int
    @Binding var playerName: String
    
    var body: some View {
        HStack {
            TextField("Player \(numPlayer)", text: $playerName)
                .padding()
        }
            .background(
                LinearGradient(gradient: Gradient(colors: [.playerCardGreen, .appGreen]), startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(17)
            .padding(.horizontal, 40.0)
            .padding(.vertical, 2.0)
            .animation(.easeInOut)
    }
}

#Preview {
    NewPlayerView(numPlayer: .constant(1), playerName: .constant("Jada"))
}
