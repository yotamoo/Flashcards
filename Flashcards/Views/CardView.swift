//
//  CardView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 01.10.21.
//

import SwiftUI

struct CardView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue)
                .frame(width: 293, height: 293)
                .shadow(color: .gray, radius: 4, x: 4, y: 4)
            
            Text(text).font(.title)
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(text: "der Hund")
    }
}
