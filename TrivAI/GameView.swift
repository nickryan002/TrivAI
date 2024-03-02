//
//  GameView.swift
//  TrivAI
//
//  Created by Nick Ryan on 12/29/23.
//

import SwiftUI

struct GameView: View {
    @Binding var topic: String
    @Binding var numPlayers: Int
    @Binding var difficulty: String
    @Binding var numQuestions: Int
    @Binding var playerNames: [Int : String]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.appGreen, .appDarkGreen]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Text("Topic: \(topic)")
                    .font(Font.custom("Aquire", size: 40))
                    .multilineTextAlignment(.center)
                Text("Difficulty: \(difficulty)").padding()
                
                Spacer()
                
                QuestionWithAnswersView(totalNumQuestions: $numQuestions, difficulty: $difficulty, topic: $topic)
                
                Spacer()
                
                ScoreCardView(numPlayers: $numPlayers, playerNames: $playerNames)
            }
        }

    }
}

#Preview {
    GameView(topic: .constant("Cows"), numPlayers: .constant(3), difficulty: .constant("Hard"), numQuestions: .constant(10), playerNames: .constant([1: "Nick", 2: "Jada"]))
}
