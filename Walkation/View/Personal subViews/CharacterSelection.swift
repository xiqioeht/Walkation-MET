//
//  CharacterSelection.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/7/1.
//

import SwiftUI

import SwiftUI

struct CharacterSelection: View {
    // MARK: Gesture Properties
    @State var offsetY: CGFloat = 0
    @State var currentIndex: CGFloat = 0
    @State var showArrow: Bool = true // state variable to control arrow visibility
    
    var body: some View {
        ZStack {
            GeometryReader{
                let size = $0.size
                let cardSize = size.width * 1

                
                HeaderView()

                VStack(spacing: 0){
                    ForEach(Walkies){Walkie in
                        WalkieView(Walkie: Walkie, size: size)
                    }
                }
                .frame(width: size.width)
                .padding(.top,size.height - cardSize)
                .offset(y: offsetY)
                .offset(y: -currentIndex * cardSize)
            }
            .coordinateSpace(name: "SCROLL")
            .contentShape(Rectangle())
            .offset(x: -5)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        // Hide arrow when screen is dragged
                        if showArrow {
                            withAnimation {
                                showArrow = false
                            }
                        }

                        offsetY = value.translation.height * 0.4
                    })
                    .onEnded({ value in
                        let translation = value.translation.height

                        withAnimation(.easeInOut){
                            if translation > 0{
                                if currentIndex > 0 && translation > 250{
                                    currentIndex -= 1
                                }
                            }else{
                                if currentIndex < CGFloat(Walkies.count - 1) && -translation > 250{
                                    currentIndex += 1
                                }
                            }
                            offsetY = .zero
                        }
                    })
            )
            .onTapGesture {
                // Hide arrow when screen is tapped
                if showArrow {
                    withAnimation {
                        showArrow = false
                    }
                }
            }
            .preferredColorScheme(.light)
            
            // The arrow
            if showArrow {
                Image(systemName: "arrow.up") // Using SF Symbols for the arrow image, replace with your image if necessary
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray.opacity(0.3))
                    .offset(y: -120)
            }
        }
    }

    @ViewBuilder
    func HeaderView()->some View{
        VStack{
            HStack{

                Button {
                    
                } label: {
                    Image("Cart")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
            
            // Animated Slider
            GeometryReader{
                let size = $0.size
                
                HStack(spacing: 35){
                    ForEach(Walkies){Walkie in
                        VStack(spacing: 5){
                            Text(Walkie.title)
                                .font(.title.bold())
                                .multilineTextAlignment(.center)
                                .padding(.bottom,10)
                            Text(Walkie.Detail)
                                .font(.headline)
                                .foregroundColor(Color.gray)
                        }
                        .frame(width: size.width)
                    }
                }
                .offset(x: currentIndex * -(35+size.width),y: -20)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8), value: currentIndex)
            }
            .padding(.top,-50)
        }
        .padding(30)
    }
}



// MARK: Walkie View
struct WalkieView: View{
    var Walkie: Walkie
    var size: CGSize
    var body: some View{
        // MARK: If You Want to decrease the size of the Image, then Change it's Card Size
        let cardSize = size.width * 1
        // Since I want To show Three max cards on the display
        // Since We Used Scaling To Decrease the View Size Add Extra One
        let maxCardsDisplaySize = size.width * 4
        GeometryReader{proxy in
            let _size = proxy.size
            // MARK: Scaling Animation
            // Current Card Offset
            let offset = proxy.frame(in: .named("SCROLL")).minY - (size.height - cardSize)
            let scale = offset <= 0 ? (offset / maxCardsDisplaySize) : 0
            let reducedScale = 1 + scale
            let currentCardScale = offset / cardSize
            
            Image(Walkie.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: _size.width, height: _size.height)
                // To Avoid Warning
                // MARK: Updating Anchor Based on the Current Card Scale
                .scaleEffect(reducedScale < 0 ? 0.001 : reducedScale, anchor: .init(x: 0.5, y: 1 - (currentCardScale / 2.4)))
                // MARK: When it's Coming from bottom Animating the Scale from Large to Actual
                .scaleEffect(offset > 0 ? 1 + currentCardScale : 1, anchor: .top)
                // MARK: To Remove the Excess Next View Using Offset to Move the View in Real Time
                .offset(y: offset > 0 ? currentCardScale * 200 : 0)
                // Making it More Compact
                .offset(y: currentCardScale * -130)
        }
        .frame(height: cardSize)
    }
}


struct CharacterSelection_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSelection()
    }
}
