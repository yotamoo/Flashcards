//
//  ContentView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 30.09.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Flashcard()
    }
}

struct Flashcard: View {
    
    @State var flipped: Bool = false
    @State var rotation = 0.0
    
    var body: some View {
        ZStack {
            
        }
        .padding()
        .frame(height: 600)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .overlay(
            Text("Flashcard")
                .foregroundColor(Color.white)
                .font(.largeTitle)
        )
        .padding()
        .onTapGesture {
            flipFlashcard()
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    func flipFlashcard() {
        withAnimation(Animation.linear(duration: 0.5)) {
            rotation -= 180
            flipped.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
