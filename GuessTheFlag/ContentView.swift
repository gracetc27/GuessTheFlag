//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Grace couch on 17/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswers = Int.random(in: 1...2)

    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var gameOver = false
    @State private var questionNumber = 1

    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Guess the flag:")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                VStack(spacing: 15) {
                    VStack {
                        Text("Select flag of")
                            .font(.title.bold())
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswers])
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                    }

                    ForEach(0..<3) { number in
                        Button {
                            eachQuestion(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 10)
                                .clipShape(.rect(cornerRadius: 8))
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Text("Score \(userScore)")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
            .padding()

        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Reset Game", action: gameReset)
        } message: {
            Text("You finished with score of \(userScore)/10")
        }

    }
    func flagTapped(_ number: Int) {
        if number == correctAnswers {
            scoreTitle = "Correct"
            userScore += 1
            questionNumber += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            questionNumber += 1
        }
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswers = Int.random(in: 1...2)
    }

    func eachQuestion(_ number: Int) {
        if questionNumber == 10 {
            scoreTitle = "Game Over!"
            gameOver = true
        } else {
            flagTapped(number)
        }
    }

    func gameReset() {
        userScore = 0
        questionNumber = 1
    }
}






#Preview {
    ContentView()
}
