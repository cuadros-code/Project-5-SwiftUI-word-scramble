//
//  ContentView.swift
//  Project-5-SwiftUI-word-scramble
//
//  Created by Kevin Cuadros on 15/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            // The Icon exist 1 to 50
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            
            .alert(errorTitle, isPresented: $showingError) {}
                message: {
                    Text(errorMessage)
                }
        }
        
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard answer.count > 0 else { return }
        
        guard isDifferent(word: answer) else {
            wordError(
                title: "Use a different word",
                message: "Make sure the word is different from the original"
            )
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPosible(word: answer) else {
            wordError(
                title: "Word not posible",
                message: "You can't spell that word from '\(rootWord)'!"
            )
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you kwnw!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContent = try? String(
                contentsOf: fileUrl,
                encoding: .ascii
            ) {
                let words = fileContent.components(separatedBy: "\n")
                rootWord = words.randomElement() ?? "wreathed"
                return
            }
        }
        
        fatalError("Could not load file")
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPosible(word: String) -> Bool {
        
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let textChecker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let isReal = textChecker
            .rangeOfMisspelledWord(
                in: word,
                range: range,
                startingAt: 0,
                wrap: false,
                language: "en"
            )
        
        return isReal.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func isDifferent(word: String) -> Bool {
        if word.count < 3 || word == rootWord {
            return false
        }
        return true
    }
     
    
}

#Preview {
    ContentView()
}
