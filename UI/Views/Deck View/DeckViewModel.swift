//
//  DeckViewModel.swift
//  Flashcards
//
//  Created by Justyna Kleczar on 15/10/2021.
//

import Foundation
import Common

public class DeckViewViewModel: ObservableObject {
    @Published var progress: Double = 0
    @Published var flashcardModel: FlashcardModel?
    @Published var didFinish = false
    @Published var showAlert = false
    let title: String
    
    private let flashcardModels: [FlashcardModel]
    private var index: Int = 0 {
        didSet {
            progress = Double(index) / Double(flashcardModels.count) * 100
        }
    }
    
    init(title: String, flashcardModels: [FlashcardModel]) {
        self.title = title
        self.flashcardModels = flashcardModels
        self.flashcardModel = flashcardModels.first
    }
    
    func cardViewed(_ success: Bool, model: FlashcardModel) {
        print(success ? "well done" : "next time")
        index += 1
        if index < flashcardModels.count {
            flashcardModel = flashcardModels[index]
        }
        else {
            print("finished")
            didFinish = true
        }
    }
    
    func backButtonPressed() {
        showAlert = true
    }
}
