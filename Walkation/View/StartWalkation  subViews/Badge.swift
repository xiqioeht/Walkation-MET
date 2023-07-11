//
//  Badge.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/7/3.
//

import SwiftUI

struct Badge: View {
    // MARK: Animation Properties
    @State var expandCard: Bool = false
    @State var showContent: Bool = false
    @State var showLottieAnimation: Bool = false
    @Binding var selection: Int?
    @Namespace var animation
    var body: some View {
        VStack{
            // MARK: Header
            HStack{
                Spacer()
                
                Button {
                    
                } label: {
                  //  Text("BACK")
                     //   .fontWeight(.semibold)
                      //  .foregroundColor(Color.black)
                }
            }
            
            CardView()
            
            // MARK: Footer Content
            Text("Woohoo!")
                .font(.system(size: 35,weight: .bold))
                .foregroundColor(Color.black)
            
            Text("You've unlocked a new badge!!!")
                .foregroundColor(Color.black)
                .kerning(1.02)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            
            Button {
                selection = 5
            } label: {
                Text("Back")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,17)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(Color("Green"))
            }
            .cornerRadius(20)
            .padding(.top,50)

        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background (
            Color("BG")
                .ignoresSafeArea()
        )
        .overlay(content: {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(showContent ? 1 : 0)
                .ignoresSafeArea()
        })
        .overlay(content: {
            GeometryReader{proxy in
                let size = proxy.size
                
                if expandCard{
                    // MARK: Since Size Varies
                    // By Padding 15 + 15 = 30
                    GiftCardView(size: size)
                        .overlay(content: {
                            // MARK: Lottie Animation
                            if showLottieAnimation{
                                ResizableLottieView(fileName: "Party") { view in
                                    withAnimation(.easeInOut){
                                        showLottieAnimation = false
                                    }
                                }
                                .scaleEffect(1.4)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            }
                        })
                        .matchedGeometryEffect(id: "GIFTCARD", in: animation)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(x: 1)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.35)){
                                showContent = true
                                showLottieAnimation = true
                            }
                        }
                }
            }
            .padding(30)
        })
        .overlay(alignment: .topTrailing, content: {
            // MARK: Close Button
            Button {
                withAnimation(.easeInOut(duration: 0.35)){
                    showContent = false
                    showLottieAnimation = false
                }
                
                withAnimation(.easeInOut(duration: 0.35).delay(0.1)){
                    expandCard = false
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(15)
            }
            .opacity(showContent ? 1 : 0)
        })
    }
    
    // MARK: Card View
    @ViewBuilder
    func CardView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            ScratchCardView(pointSize: 60) {
                // MARK: Gift Card
                if !expandCard{
                    GiftCardView(size: size)
                        .matchedGeometryEffect(id: "GIFTCARD", in: animation)
                }
            } overlay: {
                Image("card1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width * 0.9, height: size.width * 0.9,alignment: .topLeading)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            } onFinish: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                        expandCard = true
                    }
                }
            }
            .frame(width: size.width, height: size.height, alignment: .center)
        }
        .padding(15)
    }
    
    // MARK: Gift Card
    @ViewBuilder
    func GiftCardView(size: CGSize)->some View{
        VStack(spacing: 18){
            Image("Trophy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            
            Text("You Won")
                .font(.callout)
                .foregroundColor(.gray)
            
            HStack{
                Text("Park Badge")
            }
            .font(.title.bold())
            .foregroundColor(.black)
            
            Text("It will be attached to your badge wall")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(20)
        .frame(width: size.width * 0.9, height: size.width * 0.9)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
    }
}

struct Badge_Previews: PreviewProvider {
    @State static var selection: Int? = 4
    static var previews: some View {
        Badge(selection: $selection)
    }
}
