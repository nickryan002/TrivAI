//
//  GameView.swift
//  TrivAI
//
//  Created by Nick Ryan on 12/29/23.
//

import SwiftUI

struct StartGameView: View {
    @State var topic: String = ""
    @State var difficulty: String = "Easy"
    @State var numPlayers = 1
    @State var numQuestions: Int = 10
    @State var playerNames: [Int : String] = [:]
    
    let maxPlayersRange = 1...4
    let step = 1
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.appGreen, .appDarkGreen]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                
                
                VStack(spacing: 30) {
                    Text("What topic would you like?")
                    TextField("Ex: Cars, WW1", text: $topic)
                        .padding(10)
                        .frame(width: 350, height: 40)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    
                    
                    
                    VStack {
                        Text("Difficulty level: \(difficulty)")
                        
                        Menu {
                            Picker(selection: $difficulty) {
                                Text("Easy").tag("easy")
                                Text("Moderate").tag("moderate")
                                Text("Hard").tag("hard")
                            } label: {}
                        } label: {
                            Text("Change").padding().foregroundColor(Color(.appButtonGray))
                        }
                        
                        
                    }
                    
                    AddPlayersView(numPlayers: $numPlayers, playerNames: $playerNames)
                    
                    
                    
                }.padding()
                
                
                NavigationLink {
                    GameView(topic: $topic, numPlayers: $numPlayers, difficulty: $difficulty, numQuestions: $numQuestions, playerNames: $playerNames)
                } label: {
                    Text("Start").foregroundColor(Color(.appButtonGray))
                }.padding()
                
                
            }
        }
    }
}

#Preview {
    StartGameView()
}
