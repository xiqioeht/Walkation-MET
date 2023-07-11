//
//  GameCard.swift
//  iMessageCardSwipe
//
//  Created by Theoxiqi on 2023/6/26.
//

import SwiftUI

struct GameCard: View {
    // MARK: Gesture Properties
    var index: Int
    @Binding var selection: Int?
    @State var offset: CGSize = .zero
    @State private var isBadgeViewPresented = false
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            let imageSize = (size.width * 1) > 350 ? 350 : size.width * 1
            let cardWidth: CGFloat = screenSize.width * 0.8
            let cardHeight: CGFloat = cardWidth * (5/3)
            
            VStack{
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack{
                     /*   Button(action: {
                            // 在這裡添加操作
                            // self.isPrivacyViewPresented = true
                          //  self.isBadgeViewPresented = true
                            print("Hello")
                           selection = 4
                      //    Badge(selection: $selection)
                        }) {
                            
                            Text("Next")
                                .fontWeight(.bold)
                                .foregroundColor(Color("BG"))
                                .padding(.vertical,12)
                                .padding(.horizontal,15)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color("next"))
                                        .brightness(-0.1)
                                }.offset(x:120, y:300)
                        } .padding(.top,14)
                         */
                    }
                        
                       

                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .lineLimit(1)
            .foregroundColor(.white)
            .padding(.top,5)
            .padding(.horizontal,15)
            .frame(width: imageSize)
            .background(content: {
                ZStack(alignment: .topTrailing){
                    Image("gm\(index + 1)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            })
            .frame(width: cardWidth, height: cardHeight)
            .rotation3DEffect(offset2Angle(true), axis: (x: -1, y: 0, z: 0))
            .rotation3DEffect(offset2Angle(), axis: (x: 0, y: 1, z: 0))
            // Optional
            .rotation3DEffect(offset2Angle(true) * 0.1, axis: (x: 0, y: 0, z: 1))
            .scaleEffect(0.9)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation
                    }).onEnded({ _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.32, blendDuration: 0.32)){
                            offset = .zero
                        }
                    })
            )
        }
    }
    
    // MARK: Converting Offset Into X,Y Angles
    func offset2Angle(_ isVertical: Bool = false)->Angle{
        let progress = (isVertical ? offset.height : offset.width) / (isVertical ? screenSize.height : screenSize.width)
        return .init(degrees: progress * 10)
    }
    
    // MARK: Device Screen Size
    var screenSize: CGSize = {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        return window.screen.bounds.size
    }()
    
    @ViewBuilder
    func BlendedText(_ text: String)->some View{
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .fontWidth(.condensed)
            .blendMode(.difference)
    }
}

struct GameCard_Previews: PreviewProvider {
    @State static var selection: Int? = 3
    static var previews: some View {
        // Use a dummy value for index
        GameCard(index: 0, selection: $selection)
    }
}
