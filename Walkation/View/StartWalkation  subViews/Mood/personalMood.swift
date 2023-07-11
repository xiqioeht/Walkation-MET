//
//  personalMood.swift
//  Walkation
//
//  Created by 馬玉駿 on 4/7/2023.
//

import Foundation
import SwiftUI


struct PersonalMoodView: View {
    @State var data: [String] = []
    @State var columns: [GridItem] = []
    @State private var currentDate = Date()
    @State private var firstDouble: Int = 0
    @State private var secondDouble: Double = 0.0
    @State var key1: [Int] = []
    @State var key2: [Double] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Date: \(currentDate, formatter: dateFormatter)")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading, 40)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 50) {
                        ForEach(data.indices, id: \.self) { index in
                            let currentKey1 = key1.indices.contains(index) ? key1[index] : 0
                            let currentKey2 = key2.indices.contains(index) ? key2[index] : 0.0
                            CustomPolygon1(sides: currentKey1, controlPointMultiplier: currentKey2)
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color("Flower1"),
                                                                    Color("Flower2"),
                                                                    Color("Flower3").opacity(0.3),
                                                                    Color("Flower4")]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: 25
                                    )
                                )
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding()
                }
                
          
            
                .padding()
            }
        
            
            .onAppear() {
                // 初始化数据
                let dbHelper = DBHelper()
                let moodList = dbHelper.readMood()
                for mood in moodList {
                    print("currentSlides: \(mood.currentSlides), currentMultiplier: \(mood.currentMultiplier)")
                    self.key1.append(Int(mood.currentSlides)!)
                    self.key2.append(Double(mood.currentMultiplier)!)
                    self.data.append("\(mood.currentMultiplier)")
                }
                let count = min(data.count, 6)
                self.columns = Array(repeating: GridItem(.flexible(), alignment: .leading), count: count)
                
                // 更新当前日期
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    self.currentDate = Date()
                }
            }
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

struct personalMood_Previews: PreviewProvider {
    
    static var previews: some View {
       PersonalMoodView()
    }
}

struct CustomPolygon1: Shape {
    var sides: Int
    let radius: CGFloat = 25 // 將半徑設為 25
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
