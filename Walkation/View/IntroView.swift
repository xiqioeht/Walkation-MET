
import SwiftUI

struct IntroView: View {
    // MARK: Animation Properties
    @AppStorage("introShown") var introShown: Bool = false
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView: Bool = false
    @Namespace var animation
    var body: some View {
        ZStack{
            if showHomeView{
                Home()
                    .transition(.move(edge: .trailing))
            }else{
                ZStack{
                    Color("BG")
                        .ignoresSafeArea()
                    
                    IntroScreen()
                    
                    WalkThroughScreens()
                    
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: introShown)
    }
    
    // MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens()->some View{
        let isLast = currentIndex == intros.count
        
        GeometryReader{
            let size = $0.size
            
            ZStack{
                // MARK: Walk Through Screens
                ForEach(intros.indices,id: \.self){index in
                    ScreenView(size: size, index: index)
                }
                
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .overlay(alignment: .bottom, content: {
                Indicators()
                    .opacity(isLast ? 0 : 1)
                    .animation(.easeInOut(duration: 0.35), value: isLast)
                    .offset(y: -180)
            })
            // MARK: Next Button
            .overlay(alignment: .bottom) {
                // MARK: Converting Next Button Into SignUP Button
                ZStack{
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack{
                        Text("Sign Up")
                            .font(.custom(sansBold, size: 15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal,15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                        .fill(Color("Green"))
                }
                .onTapGesture {
                    if currentIndex == intros.count{
                        // Signup Action
                        introShown = true
                    }else{
                        // MARK: Updating Index
                        currentIndex += 1
                    }
                }
                .offset(y: isLast ? -40 : -90)
                // Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .overlay(alignment: .bottom, content: {
                // MARK: Bottom Sign In Button
                let isLast = currentIndex == intros.count
                
                HStack(spacing: 5){
                    Text("Already have an account?")
                        .font(.custom(sansRegular, size: 14))
                        .foregroundColor(.gray)
                    
                    Button("Login"){
                        
                    }
                    .font(.custom(sansBold, size: 14))
                    .foregroundColor(Color("Green"))
                }
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
        
    }
    
    // MARK: Indicator View
    // Forgot to add in the YT Video
    @ViewBuilder
    func Indicators()->some View{
        HStack(spacing: 8){
            ForEach(intros.indices,id: \.self){index in
                Circle()
                    .fill(.gray.opacity(0.2))
                    .frame(width: 8, height: 8)
                    .overlay {
                        if currentIndex == index{
                            Circle()
                                .fill(Color("Green"))
                                .frame(width: 8, height: 8)
                                .matchedGeometryEffect(id: "INDICATOR", in: animation)
                        }
                    }
            }
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: currentIndex)
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize,index: Int)->some View{
        let intro = intros[index]
        
        VStack(spacing: 10){
            Text(intro.title)
                .font(.custom(sansBold, size: 28))
                // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
                // MARK: Adding Animation
                // MARK: Adding Delay to Elements based On Index
                // My Delay Starts From Top
                // You can also modify code to start delay from Bottom
                // Delay:
                // 0.2, 0.1, 0
                // Adding Extra 0.2 For Current Index
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250,alignment: .top)
                .padding(.horizontal,20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
        .offset(y: -30)
    }
    
    // MARK: Welcome Screen
    @ViewBuilder
    func WelcomeView(size: CGSize,index: Int)->some View{
        VStack(spacing: 20){
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 400,alignment: .top)
                .padding(.horizontal,20)
                .offset(x: -size.width * CGFloat(currentIndex - index), y: -20)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Welcome")
                .font(.custom(sansBold, size: 28))
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Get a break in life and a daily resort with\nWalkation app.")
                .font(.custom(sansRegular, size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
        }
        .offset(y: -30)
    }
    
    // MARK: Nav Bar
    @ViewBuilder
    func NavBar()->some View{
        let isLast = currentIndex == intros.count
        
        HStack{
            Button {
                // If Greater Than Zero Then Eliminating Index
                if currentIndex > 0{
                    currentIndex -= 1
                }else{
                    showWalkThroughScreens.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Green"))
            }

            Spacer()
            
            Button("Skip"){
                currentIndex = intros.count
            }
            .font(.custom(sansRegular, size: 14))
            .foregroundColor(Color("Green"))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal,15)
        .padding(.top,10)
        .frame(maxHeight: .infinity,alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen()->some View{
        GeometryReader{
            let size = $0.size
            
            VStack(spacing: 0){
                        Image("walkation")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width * 0.8, height: size.height / 1.5).offset(y:30) // Make image 80% of screen width and reduce height
                
                /*Text("Walkation")
                    .font(.custom(sansBold, size: 27))
                    .offset(y: -50)*/
                
                Text(dummyText)
                    .font(.custom(sansRegular, size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,30) .offset(y: -50)
                
                Text("Let's Begin")
                    .font(.custom(sansSemiBold, size: 18))
                    .padding(.horizontal,40)
                    .padding(.vertical,14)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill(Color("Green"))
                    }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top,30)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            // MARK: Moving Up When Clicked
            .offset(y: showWalkThroughScreens ? -size.height : 0)
        }
        .ignoresSafeArea()
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

// MARK: Home View
struct Home: View{
    var body: some View{
        NavigationStack{
            Text("")
                .navigationTitle("Home")
        }
    }
}
