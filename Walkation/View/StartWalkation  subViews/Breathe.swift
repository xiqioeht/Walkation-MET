//
//  Breathe.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/7/4.
//

import SwiftUI

struct Breathe: View {
    @Binding var selection: Int?
    // MARK: View Properties
    @State var currentType: BreatheType = sampleTypes[0]
    @Namespace var animation
    // MARK: Animation Properties
    @State var showBreatheView: Bool = false
    @State var startAnimation: Bool = false
    // MARK: Timer Properties
    @State var timerCount: CGFloat = 0
    @State var breatheAction: String = "Breathe In"
    @State var count: Int = 0
    // MARK: Breath duration
    @State var breathDuration: Double = 3.0
    // MARK: Color hue control
    @State var hue: Double = 0.5

    var body: some View {
        ZStack{
            Background()
            Content()
            
            Text(breatheAction)
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity,alignment: .top)
                .padding(.top,50)
                .opacity(showBreatheView ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: breatheAction)
                .animation(.easeInOut(duration: 1), value: showBreatheView)
        }
        // MARK: Timer
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            if showBreatheView{
                if timerCount >= CGFloat(breathDuration) {
                    timerCount = 0
                    breatheAction = (breatheAction == "Breathe Out" ? "Breathe In" : "Breathe Out")
                    withAnimation(.easeInOut(duration: breathDuration).delay(0.1)){
                        startAnimation.toggle()
                    }
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                } else {
                    timerCount += 0.01
                }

                count = Int(breathDuration) - Int(timerCount)
            } else {
                timerCount = 0
            }
        }/*.preferredColorScheme(.dark)*/
    }
    
    // MARK: Main Content
    @ViewBuilder
    func Content()->some View{
      
        VStack{

            VStack {
                HStack {
                    Text("Breathe")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Slider(value: $hue, in: 0...1)
                        .accentColor(Color(hue: hue, saturation: 1, brightness: 1))
                          
                }
                .padding()
                .opacity(showBreatheView ? 0 : 1)
              
            }
            
            .padding(.top, UIScreen.main.bounds.height <= 667 ? -20 : 0) // Adjust padding based on screen height
         
           
           
            GeometryReader{proxy in
                let size = proxy.size
                let color = Color(hue: hue, saturation: 0.6, brightness: 0.9)
                VStack{
                    BreatheView(size: size)
                        .frame(maxHeight: .infinity,alignment: .center)
                    
                    // MARK: View Properties
                    Text("Let's breathe with the flower.")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .opacity(showBreatheView ? 0 : 1)
                    
                    HStack {
                        Button(action: { breathDuration = 3.0 }) {
                            Text("3 seconds")
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .foregroundColor(breathDuration == 3.0 ? .black : .white)
                                .padding(.vertical,10)
                                .padding(.horizontal,15)
                                .background(RoundedRectangle(cornerRadius: 10)
                                                .fill(breathDuration == 3.0 ? .white : Color.clear))
                        }
                        
                        Button(action: { breathDuration = 5.0 }) {
                            Text("5 seconds")
                                .fontWeight(.bold)
                                .foregroundColor(breathDuration == 5.0 ? .black : .white)
                                .padding(.vertical,10)
                                .padding(.horizontal,15)
                                .font(.system(size: 15))
                                .background(RoundedRectangle(cornerRadius: 10)
                                                .fill(breathDuration == 5.0 ? .white : Color.clear))
                        }
                        
                        Button(action: { breathDuration = 7.0 }) {
                            Text("7 seconds")
                                .fontWeight(.bold)
                                .foregroundColor(breathDuration == 7.0 ? .black : .white)
                                .padding(.vertical,10)
                                .padding(.horizontal,15)
                                .font(.system(size: 15))
                                .background(RoundedRectangle(cornerRadius: 10)
                                                .fill(breathDuration == 7.0 ? .white : Color.clear))
                        }
                    }
                    .padding()
                    .opacity(showBreatheView ? 0 : 1)
                    
                    Button(action: startBreathing){
                        Text(showBreatheView ? "Finish Breathe" : "START")
                            .fontWeight(.semibold)
                            .foregroundColor(showBreatheView ? .white.opacity(0.75) : .black)
                            .padding(.vertical,15)
                            .frame(maxWidth: .infinity)
                            .background {
                                if showBreatheView{
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .stroke(.white.opacity(0.5))
                                }else{
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(color.gradient)
                                }
                            }
                    }
                    .padding()
                }
                .frame(width: size.width, height: size.height, alignment: .bottom)
            }
        }
        .frame(maxHeight: .infinity,alignment: .top)
    }
    
    // MARK: Breathe Animated Circles
    @ViewBuilder
    func BreatheView(size: CGSize)->some View {
        // Update the color here
        let color = Color(hue: hue, saturation: 0.7, brightness: 1)
        ZStack{
            ForEach(1...8,id: \.self){index in
                Circle()
                    .fill(color.gradient.opacity(0.5))
                    .frame(width: 150, height: 150)
                    .offset(x: startAnimation ? 0 : 75)
                    .rotationEffect(.init(degrees: Double(index) * 45))
                    .rotationEffect(.init(degrees: startAnimation ? -45 : 0))
                    .animation(.easeInOut(duration: breathDuration), value: startAnimation)
            }
        }
        .scaleEffect(startAnimation ? 0.8 : 1)
        .overlay(content: {
            Text("\(count == 0 ? 1 : count)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .animation(.easeInOut, value: count)
                .opacity(showBreatheView ? 1 : 0)
        })
        .frame(height: (size.width - 40))
    }
    
    // MARK: Background Image With Gradient Overlays
    @ViewBuilder
    func Background()->some View{
        let color = Color(hue: hue, saturation: 0.5, brightness: 0.8)
        GeometryReader{proxy in
            let size = proxy.size
            Image("Meditation")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y: -50)
                .frame(width: size.width, height: size.height)
                .clipped()
                // MARK: Blurring While Breathing
                .blur(radius: startAnimation ? 4 : 0, opaque: true)
                .overlay {
                    ZStack{
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                color.opacity(0.9),
                                .clear,
                                .clear
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1.5)
                            .frame(maxHeight: .infinity,alignment: .top)
                        
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                .clear,
                                .black.opacity(0.2),
                                .black.opacity(0.5),
                                .black.opacity(0.9),
                                .black,
                                .black,
                                .black
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1.35)
                            .frame(maxHeight: .infinity,alignment: .bottom)
                    }
                }
        }
        .ignoresSafeArea()
    }
    
    // MARK: Breathing Action
    func startBreathing(){
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
            showBreatheView.toggle()
        }

        if showBreatheView{
            // Set animation duration to the selected breath duration
            withAnimation(.easeInOut(duration: breathDuration).delay(0.05)){
                startAnimation = true
            }
        }else{
            withAnimation(.easeInOut(duration: breathDuration / 2)){
                startAnimation = false
            }
        }
    }
}

struct Breathe_Previews: PreviewProvider {
    @State static var selection: Int? = 7
    static var previews: some View {
        Breathe(selection: $selection)
    }
}
