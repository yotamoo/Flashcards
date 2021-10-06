//
//  DeckView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 06.10.21.
//

import SwiftUI

struct DeckView: View {
    let flashcardModels: [FlashcardModel]
    
    @State var index = 0
    
    var body: some View {
        ZStack {
            ForEach(flashcardModels) { model in
                FlashcardView(model: model) {
                    print($0 ? "well done" : "next time")
                    if index + 1 < flashcardModels.count {
                        index += 1
                    }
                    else {
                        print("finished!")
                    }
                }
            }
        }
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(flashcardModels: [])
    }
}
