//
//  MoodSelection.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//

import SwiftUI

struct MoodSelection: View {
    
    // Gesture Properties...
    @State var offset: CGFloat = 0
    @State var offset2: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State private var showConfirmationAlert = false
    // Control the number of sides of the shape
    // Range from 3 (triangle) to 8 (octagon)
    @State var currentSides: Int = 5
    
    // Control the controlPointRadius multiplier
    @State var currentMultiplier: CGFloat = 1.0

    var body: some View{
        
        VStack(spacing: 15){
            
            Text(getAttributedString())
                .font(.system(size: 45))
                .fontWeight(.medium)
                .kerning(1.1)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            GeometryReader { geometry in
                let size = geometry.size
                
                CustomPolygon(sides: currentSides, controlPointMultiplier: currentMultiplier)
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [Color("Flower1"),
                                                        Color("Flower2"),
                                                        Color("Flower3").opacity(0.3),
                                                        Color("Flower4")]),
                            center: .center,
                            startRadius: 0,
                            endRadius: size.width/2.5
                        )
                    )
                    .frame(width: size.width/2, height: size.height/2)
                    .scaleEffect(1)
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)

            }.offset(y:-50)
            
            // Sliders...
            ForEach(0..<2) { index in
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color("Green").opacity(0.6))
                            .frame(height: 1)
                        
                        HStack {
                            Text(index == 0 ? "Low" : "Unpleasant")
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                            Spacer()
                            Text(index == 0 ? "High" : "Pleasant")
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                        }.offset(y: -30)
                        
                        Group {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("Green"))
                                .frame(width: 55, height: 15)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 11, height: 11)
                        }
                        .frame(maxWidth: .infinity,alignment: .center)
                        .contentShape(Rectangle())
                        .offset(x: index == 0 ? offset : offset2)
                        .gesture(
                            DragGesture(minimumDistance: 5)
                                .updating($isDragging, body: { _, out, _ in
                                    out = true
                                })
                                .onChanged({ value in
                                    let width = UIScreen.main.bounds.width - 30
                                    var translation = value.location.x
                                    translation = (translation > 27 ? translation : 27)
                                    translation = (translation < (width - 27) ? translation : (width - 27))
                                    translation = isDragging ? translation : 0
                                    
                                    if index == 0 {
                                        offset = translation - (width / 2)
                                        let sides = Int((translation - 27) / (width - 55) * 7 + 3)
                                        currentSides = sides
                                    } else {
                                        offset2 = translation - (width / 2)
                                        let multiplier = (translation - 27) / (width - 55) * 2 + 0
                                        currentMultiplier = multiplier
                                    }
                                })
                        )
                    }
                    .padding(.bottom,20)
                    .offset(y: -10)
                }
            }
            
           
            Button(action: {
                // Add action code here, for example:
                print("Button tapped with action")
                
                // Save mood to database
                let dbHelper = DBHelper()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let dateString = formatter.string(from: Date())
                dbHelper.insertMood(currentSlides: "\(currentSides)", currentMultiplier: "\(currentMultiplier)", date: dateString)
                
                // Show confirmation alert
                showConfirmationAlert = true
                
            }) {
                Text("Done")
                    .font(.title3)
                    .fontWeight(.medium)
                    .kerning(1.1)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .background(
                        Color("Green"),in: RoundedRectangle(cornerRadius: 18)
                    )
            }
            .padding(.horizontal,15)
            .alert(isPresented: $showConfirmationAlert) {
                Alert(
                    title: Text("Mood Recorded"),
                    message: Text("Your mood has been recorded."),
                    dismissButton: .default(Text("OK"))
                )
            }
         

        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [
                Color("Green").opacity(0.4),
                Color("Green").opacity(0.6),
                Color("Green").opacity(0.8),
                Color("Green").opacity(1.0),
                Color("Green").opacity(1.0),
                Color("Green").opacity(1.0),
                Color("Green").opacity(1.0),
                Color("Green").opacity(1.0),
                Color("Green").opacity(1.0),
                Color("Green").opacity(0.9),
                Color("Green").opacity(0.8),
                Color("Green").opacity(0.7),
                Color("Green").opacity(0.5),
                Color("Green").opacity(0.3),
                Color("Green").opacity(0.1),
                Color.white.opacity(0.1),
                Color.white.opacity(0.5),
                Color.white.opacity(0.7),
                Color.white.opacity(1.0)
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        )
       /* .overlay(
         Button(action: {}, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
            })
                .padding(.trailing)
                .padding(.top)
            
            ,alignment: .topTrailing
        )*/
    }
    
    // Attributed String...
    func getAttributedString()->AttributedString{
        
        var str = AttributedString("How was \nyour Mood?")
        
        if let range = str.range(of: "Mood?"){
            str[range].foregroundColor = .white
        }
        
        return str
    }
}

struct CustomPolygon: Shape {
    var sides: Int
    let radius: CGFloat = 100 // this is your constant radius
    var controlPointMultiplier: CGFloat // the control point radius as a multiplier of the radius

    func path(in rect: CGRect) -> Path {
        guard sides >= 3 else { return Path() } // need at least 3 sides to draw a polygon

        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var path = Path()
        let angleIncrement = 360.0 / CGFloat(sides)
        let radianIncrement = angleIncrement * CGFloat.pi / 180.0
        let controlPointRadius = radius * controlPointMultiplier // adjust this value to control the bulge of the arcs

        for i in 0..<sides {
            let startAngle = ((CGFloat(i) * angleIncrement) - 90.0) * CGFloat.pi / 180.0
            let endAngle = startAngle + radianIncrement

            let startPoint = CGPoint(x: center.x + cos(startAngle) * radius, y: center.y + sin(startAngle) * radius)
            let endPoint = CGPoint(x: center.x + cos(endAngle) * radius, y: center.y + sin(endAngle) * radius)

            let midPointAngle = startAngle + radianIncrement / 2
            let controlPoint = CGPoint(x: center.x + cos(midPointAngle) * controlPointRadius, y: center.y + sin(midPointAngle) * controlPointRadius)

            if i == 0 {
                path.move(to: startPoint)
            }

            path.addQuadCurve(to: endPoint, control: controlPoint)
        }
        path.closeSubpath()

        return path
    }
}

struct MoodSelection_Previews: PreviewProvider {
    static var previews: some View {
        MoodSelection()
    }
}
