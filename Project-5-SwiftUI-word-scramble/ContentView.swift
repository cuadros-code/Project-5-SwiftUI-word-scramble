//
//  ContentView.swift
//  Project-5-SwiftUI-word-scramble
//
//  Created by Kevin Cuadros on 15/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List{
            Section("Home"){
                ForEach(0..<5) { _ in
                    Text("Hello word")
                }
            }
            
            Text("Remeber")
        }
        .listStyle(.grouped)
    }
}

#Preview {
    ContentView()
}
