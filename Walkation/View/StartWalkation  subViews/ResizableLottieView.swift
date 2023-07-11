//
//  SwiftUIView.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/7/3.
//

import SwiftUI
import Lottie

struct ResizableLottieView: UIViewRepresentable {
    var fileName: String
    // MARK: Callback When Animation Finishes
    var onFinish: (LottieAnimationView)->()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupView(for: view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func setupView(for to: UIView){
        // MARK: Setting Up Lottie View
        let LottieAnimationView = LottieAnimationView(name: fileName,bundle: .main)
        LottieAnimationView.backgroundColor = .clear
        LottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: For Optimized Memory
        LottieAnimationView.shouldRasterizeWhenIdle = true
        
        let constraints = [
            LottieAnimationView.widthAnchor.constraint(equalTo: to.widthAnchor),
            LottieAnimationView.heightAnchor.constraint(equalTo: to.heightAnchor),
        ]
        
        to.addSubview(LottieAnimationView)
        to.addConstraints(constraints)
        
        LottieAnimationView.play{_ in
            onFinish(LottieAnimationView)
        }
    }
}
