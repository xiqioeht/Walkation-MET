import SwiftUI

class MyTimer {
    private var timer: Timer?
    private let energyCollection: EnergyCollection
    
    init(energyCollection: EnergyCollection) {
        self.energyCollection = energyCollection
    }
    
    func start() {
        //30s call
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            self.energyCollection.performAnimation()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
}

struct EnergyCollection: View {
    // MARK: Animation Properties
    @State var dragOffset: CGSize = .zero
    @State var percentage: Int = 1
    @Binding var selection: Int?
    let animationDuration: Double = 0.6 // Duration of the animation
    let topBallOffset: CGFloat = -200 // Initial y offset for the top ball
    
    var body: some View {
        VStack{
            ZStack {
                SingleEnergyBall()
                Text("\(percentage)%")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .background(Color.clear)
            .onTapGesture {
                if percentage < 100 {
                    self.performAnimation()
                }
            }
            .onAppear() {
                dragOffset = CGSize(width: 0, height: topBallOffset)
            }
            .background(Color.clear)
        }
        .background(Color.clear)
        .onAppear() {
            // 在这里创建一个 MyTimer 对象，并启动定时器
            let myTimer = MyTimer(energyCollection: self)
            myTimer.start()
        }
    }
    
    // MARK: Single EnergyBall Animation
    @ViewBuilder
    func SingleEnergyBall()->some View{
        Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [
                    Color("Energy1").opacity(Double(percentage) / 100.0),
                    Color("Energy2")
                ]),
                startPoint: .top,
                endPoint: .bottom
            ))
            .mask {
                Canvas { context, size in
                    context.addFilter(.alphaThreshold(min: 0.5,color: .yellow))
                    context.addFilter(.blur(radius: 25))
                    
                    context.drawLayer { ctx in
                        if percentage < 100 {
                            for index in [1,2]{
                                if let resolvedView = context.resolveSymbol(id: index){
                                    ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                }
                            }
                        } else {
                            if let resolvedView = context.resolveSymbol(id: 1){
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    Ball(size: 150) // bottom ball
                        .tag(1)
                    
                    Ball(size: 75, offset: dragOffset) // top ball
                        .tag(2)
                }
            }
    }
    
    @ViewBuilder
    func Ball(size: CGFloat, offset: CGSize = .zero)->some View{
        Circle()
            .fill(.white)
            .frame(width: size, height: size)
            .offset(offset)
    }
    
    // MARK: Perform Animation
    func performAnimation() {
        withAnimation(.interactiveSpring(response: animationDuration, dampingFraction: 0.7, blendDuration: 0.7)) {
            dragOffset = .zero
            percentage += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            dragOffset = CGSize(width: 0, height: topBallOffset)
        }
    }
}

struct EnergyCollection_Previews: PreviewProvider {
    @State static var selection: Int? = 6
    static var previews: some View {
        EnergyCollection(selection: $selection)
    }
}
