//
//  ContentView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 30.09.21.
//

import SwiftUI

public struct ContentView: View {
    public init() {}
    
    public var body: some View {
        DeckGalleryView(viewModel: DeckGalleryViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
