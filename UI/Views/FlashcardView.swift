//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Yotam Ohayon on 01.10.21.
//

import SwiftUI
import Common

public struct FlashcardView: View {
    @State private var flipped = false
    @State private var animate3d = false
    @State private var translation: CGSize = .zero
    
    let model: FlashcardModel
    let completion: (Bool, FlashcardModel) -> Void

    public init(model: FlashcardModel, completion: @escaping (Bool, FlashcardModel) -> Void) {
        self.model = model
        self.completion = completion
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                CardView(text: model.front).opacity(flipped ? 0.0 : 1.0)
                CardView(text: model.back).opacity(flipped ? 1.0 : 0.0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 0, y: 1)))
            .onTapGesture {
                withAnimation(.linear(duration: 0.5)) {
                    self.animate3d.toggle()
                }
            }
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        guard flipped else { return }
                        self.translation = value.translation
                    }.onEnded { value in
                        guard flipped else { return }
                        let limit = geometry.size.width * 0.3
                        if value.translation.width > limit  {
                            withAnimation(.linear(duration: 0.5)) {
                                self.translation.width = geometry.size.width
                            }
                            completion(true, model)
                        }
                        else if value.translation.width < -limit {
                            withAnimation(.linear(duration: 0.5)) {
                                self.translation.width = -geometry.size.width
                            }
                            completion(false, model)
                        }
                        else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}

struct FlipEffect: GeometryEffect {
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        
        let tweakedAngle = flipped ? -180 + angle : angle
        let a = CGFloat(Angle(degrees: tweakedAngle).radians)
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1 / max(size.width, size.height)
        
        transform3d = CATransform3DRotate(
            transform3d,
            a,
            axis.x,
            axis.y, 0
        )
        
        transform3d = CATransform3DTranslate(
            transform3d,
            -size.width / 2.0,
            -size.height / 2.0, 0
        )
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(
            model: .init(id: .init(), front: "der Hund", back: "dog")
        ) { _, _ in }
    }
}
