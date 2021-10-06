//
//  DeckView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import SwiftUI

struct DeckView: View {
    @State var flashcardModels: [FlashcardModel]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(flashcardModels: [])
    }
}
