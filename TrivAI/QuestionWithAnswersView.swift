//
//  QuestionWithAnswerView.swift
//  TrivAI
//
//  Created by Nick Ryan on 1/10/24.
//

import SwiftUI

struct QuestionWithAnswersView: View {
    @Binding var numQuestions: Int
    @Binding var difficulty: String
    @Binding var topic: String
    
    @State private var triviaItems: [TriviaItem] = []
    @State private var currentQuestionIndex = 0

    @State private var revealAnswer: Bool = false
    @State private var answerOpacity: Double = 0.0
    
    let initialNumberOfQuestions: Int = 2
    let numberOfQuestionsIncrement: Int = 8

    var body: some View {
        ScrollView {
            VStack {
                if !triviaItems.isEmpty && currentQuestionIndex < triviaItems.count {
                    Text("\(triviaItems[currentQuestionIndex].question)")
                        .multilineTextAlignment(.center).padding()
                        .lineLimit(nil)
                    
                    ForEach(triviaItems[currentQuestionIndex].options.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        Text("\(key): \(value)")
                            .multilineTextAlignment(.center)
                    }
                    
                    if revealAnswer {
                        Text("Answer: \(triviaItems[currentQuestionIndex].correctAnswer)")
                            .opacity(answerOpacity)
                            .font(Font.custom("Aquire", size: 20))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    
                    Button("Tap to Reveal") {
                        withAnimation(.easeInOut(duration: 1)) {
                            revealAnswer = true
                            answerOpacity = 1.0
                        }
                    }.foregroundColor(.appButtonGray)
                        .padding()
                    
                    Button("Next Question") {
                        revealAnswer = false
                        answerOpacity = 0.0
                        currentQuestionIndex += 1
                        
//                        if currentQuestionIndex == 2 && triviaItems.count < numQuestions {
//                            // Load remaining questions
//                            loadRemainingTrivia()
//                        }
                        
                    }.foregroundColor(.appButtonGray)
                        .padding()
                } else if currentQuestionIndex >= numQuestions {
                    Text("Congrats!")
                } else {
                    Text("Loading Questions...")
                }
            }
            .onAppear {
                startTriviaSession()
                getNextQuestions()
            }
        }
    }

    func startTriviaSession() {
        // Make a request to the start trivia function of the Flask API
        let startQueryItems = [
            URLQueryItem(name: "numQuestions", value: "\(numQuestions)"),
            URLQueryItem(name: "difficulty", value: difficulty),
            URLQueryItem(name: "topic", value: topic)
        ]
        var startUrlComps = URLComponents(string: "http://127.0.0.1:5000/start_trivia")!
        startUrlComps.queryItems = startQueryItems

        guard let startUrl = startUrlComps.url else {
            print("Invalid Start URL")
            return
        }

        var startRequest = URLRequest(url: startUrl)
        startRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: startRequest) { data, response, error in
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Start Trivia Response: \(responseString)")
                // After initializing, fetch the initial trivia questions
                getInitialTrivia()
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
    
    func getInitialTrivia() {
        getTrivia(numberOfQuestions: initialNumberOfQuestions)
    }
    
    func getNextQuestions() {
        getTrivia(numberOfQuestions: numberOfQuestionsIncrement)
    }

    func getTrivia(numberOfQuestions: Int) {
        // Adjust URL to your API endpoint and parameters
        let queryItems = [
            URLQueryItem(name: "number", value: "\(numberOfQuestions)")
        ]
        var urlComps = URLComponents(string: "http://127.0.0.1:5000/get_questions")! // Adjust API endpoint
        urlComps.queryItems = queryItems

        guard let url = urlComps.url else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let responseString = String(data: data, encoding: .utf8) ?? "Invalid response"
                
                if let jsonData = responseString.data(using: .utf8) {
                    do {
                        print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON data")
                        
                        let decodedResponse = try JSONDecoder().decode(TriviaResponse.self, from: jsonData)
                        DispatchQueue.main.async {
                            self.triviaItems.append(contentsOf: decodedResponse.questions)
                        }
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                } else {
                    print("Failed to convert String to Data")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
}


struct TriviaItem: Codable {
    var question: String
    var options: [String : String]
    var correctAnswer: String

    enum CodingKeys: String, CodingKey {
        case question
        case options
        case correctAnswer = "correct_answer"
    }
}

struct TriviaResponse: Codable {
    var questions: [TriviaItem]
}


#Preview {
    QuestionWithAnswersView(numQuestions: .constant(3), difficulty: .constant("Hard"), topic: .constant("Cars"))
}
