//
//  HomePageView.swift
//  TrivAI
//
//  Created by Nick Ryan on 12/29/23.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.appGreen, .appDarkGreen]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                    VStack {
                        Text("TrivAI")
                            .font(Font.custom("Aquire", size: 100))
                            .padding()
                        
                        NavigationLink {
                            StartGameView()
                        } label: {
                            Text("Start Game")
                                .font(Font.custom("Aquire", size: 30))
                                .foregroundStyle(Color(.appButtonGray))
                        }.padding()
                        
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Text("Settings")
                                .font(Font.custom("Aquire", size: 30))
                                .foregroundStyle(Color(.appButtonGray))
                        }.padding()
                    }
                }

            }
        }
    }
}

#Preview {
    HomePageView()
}
