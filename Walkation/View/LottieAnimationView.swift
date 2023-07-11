
import SwiftUI
import Lottie

struct LottieLottieAnimationView: UIViewRepresentable {

    var jsonFile: String
    @Binding var progress: CGFloat
    
    func makeUIView(context: Context) -> UIView {
        
        // Just Create a UIView and place the Lottie view at it's Center....
        
        let rootView = UIView()
        rootView.backgroundColor = .clear
        
        addLottieAnimationView(rootView: rootView)
        
        return rootView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
        // Updating Progress...
        // Since we used UiView to set the Given size...
        // So we cant directly use progress value..
        // Instead Finding and removing the old view and updating the new one...
        uiView.subviews.forEach { view in
            if view.tag == 1009{
                // Removing
                view.removeFromSuperview()
            }
        }
        
        addLottieAnimationView(rootView: uiView)
    }
    
    func addLottieAnimationView(rootView: UIView){
        
        let LottieAnimationView = LottieAnimationView(name: jsonFile, bundle: .main)
        
        // We need only animation from 0-0.5...
        LottieAnimationView.currentProgress = progress
        
        LottieAnimationView.backgroundColor = .clear
        LottieAnimationView.tag = 1009
        
        // Applying Auto Layout Constraints to place Lottie View in Center...
        LottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
        
            LottieAnimationView.widthAnchor.constraint(equalTo: rootView.widthAnchor),
            LottieAnimationView.heightAnchor.constraint(equalTo: rootView.heightAnchor),
        ]
        
        rootView.addSubview(LottieAnimationView)
        
        rootView.addConstraints(constraints)
    }
}
