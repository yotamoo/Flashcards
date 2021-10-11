//
//  ProgressBarView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 08.10.21.
//

import SwiftUI

struct ProgressBarView: View, Animatable {
    var progress: Double
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    var body: some View {
        return GeometryReader { geometry in
            RoundedRectangle(
                cornerSize: .init(width: 10, height: 10)
            )
                .fill(.gray)
                .overlay(
                    RoundedRectangle(
                        cornerSize: .init(width: 10, height: 10)
                    )
                        .fill(.blue)
                        .frame(
                            width: geometry.size.width / 100 * progress
                        ).animation(.linear(duration: 0.2), value: progress),
                    alignment: .leading
                )
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: 30)
            .previewLayout(
                .fixed(width: 414, height: 30)
            )
    }
}
