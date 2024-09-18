//
//  LottieView.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-17.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    var name: String

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(loopMode: .loop, name: "loading")
            .scaleEffect(0.4)
            .frame(width: 390, height: 390)
    }
}

