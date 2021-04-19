// MARK: ContentView.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/guide/ios-swiftui/3/3/challenge
 
 ASSETS :
 https://kenney.nl/assets/animal-pack-redux
 */

import SwiftUI



struct ContentView: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @State private var multiplicationNumber: Int = Int.random(in : 1...10)
    @State private var multiplicationTable: Int = 0
    @State private var yourAnswer: String = ""
    @State private var gameScore: Int = 0
    @State private var gameRound: Int = 1
    @State private var gameLength: [Int] = [ 3 , 5 , 10 , 15 ]
    @State private var selectedGameLengthIndex: Int = 0

    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var correctAnswer: Int {
        
        return multiplicationNumber * (multiplicationTable + 1)
    }
    
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Multiplication Table")) {
                    Picker("Practice the multiplication table of" ,
                           selection : $multiplicationTable) {
                        ForEach(1..<13) {
                            Text("\($0)")
                        }
                    }
                }
                Section(header: Text("Number of questions asked")) {
                    Picker("Number of challenges :" ,
                           selection : $selectedGameLengthIndex) {
                        ForEach(0..<gameLength.count) { (index: Int) in
                            return Text("\(gameLength[index])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Your challenge")) {
                    HStack {
                        Spacer()
                        Text("\(multiplicationNumber) * \(multiplicationTable + 1)")
                            .font(.largeTitle)
                        Spacer()
                    }
                }
                Section(header: Text("Your answer")) {
                    TextField("0" ,
                              text : $yourAnswer ,
                              onCommit : startNewRound)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                }
                Section(header: Text("Your Score")) {
                    VStack {
                        Text("Round \(gameRound) of \(gameLength[selectedGameLengthIndex])")
                            .font(.headline)
                        HStack {
                            Spacer()
                            Text("\(gameScore)")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle(Text("Edutainment"))
        }
    }
    
    
    
     // ////////////////////
    //  MARK: HELPERMETHODS
    
    func calculateScore() {
        
        let answer: Int = Int(yourAnswer) ?? 0
        let roundScore: Int = answer == correctAnswer ? 1 : -1
        
        gameScore += roundScore
    }
    
    
    func startNewRound() {
        gameRound < gameLength[selectedGameLengthIndex] ? calculateScore() : startNewGame()
        
        gameRound += 1
        multiplicationNumber = Int.random(in: 1...10)
    }
    
    
    func startNewGame() {
        
        gameScore = 0
        gameRound = 0
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView().previewDevice("iPhone 12 Pro")
    }
}
