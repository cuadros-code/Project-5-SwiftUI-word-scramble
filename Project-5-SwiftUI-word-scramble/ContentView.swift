//
//  ContentView.swift
//  Project-5-SwiftUI-word-scramble
//
//  Created by Kevin Cuadros on 15/10/24.
//

import SwiftUI

struct ContentView: View {
    
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        
        List(people, id: \.self){
            Text($0)
        }
        
        .onAppear{
            testBundles()
            testString()
        }
    }
    
    func testBundles() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {

            if let fileContent = try? String(
                contentsOf: fileURL,
                encoding: .ascii
            ) {
//                print(fileContent.components(separatedBy: "\n"))
            }
            
        }
    }
    
    func testString() {
        let word = "da"
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
                        
        let misspelledRange = checker
            .rangeOfMisspelledWord(
                in: word,
                range: range,
                startingAt: 0,
                wrap: false,
                language: "es"
            )
        
        let allGood = misspelledRange.location == NSNotFound
        
        print(allGood)
    }
}

#Preview {
    ContentView()
}
