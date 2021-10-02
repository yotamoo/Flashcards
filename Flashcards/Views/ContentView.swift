//
//  ContentView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 30.09.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FlashcardView(front: "front", back: "back")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
