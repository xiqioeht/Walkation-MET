
import SwiftUI

struct MainPage: View {
    // Current Tab...
    @State var currentTab: Tab = .MoodSelection
    // Animation Namespace...
    @Namespace var animation
    
    // Hiding Tab Bar...
    //将传入的 isGameCardViewActive 绑定到视图的 _isGameCardViewActive 属性上
    init(isGameCardViewActive: Binding<Bool> = .constant(false)) {
        UITabBar.appearance().isHidden = true
        _isGameCardViewActive = isGameCardViewActive
    }
    @State private var gameCardSelection: Int? = nil
    @State private var selection: Int? = nil
    @Binding var isGameCardViewActive: Bool
    @State private var isResultViewActive = false
    @State private var isBreatheViewActive = false
    
    var body: some View {
        /*ZStack {
            // Setting the MainPageBG.png image as the background
            Image("MainPageBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)*/
        VStack(spacing: 0){
            // Tab View...
            
            TabView(selection: $currentTab) {
                
                MoodSelection()
                    .tag(Tab.MoodSelection)
                
                StartWalkation()
                    .tag(Tab.StartWalkation)
                
                Personal()
                    .tag(Tab.Personal)
        }
            // Custom Tab Bar...
            HStack(spacing: 0){
                ForEach(Tab.allCases,id: \.self){tab in
                    
                    Button {
                        // updating tab...
                        currentTab = tab
                    } label: {
                     
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        // Applying little shadow at bg...
                            .background(
                            
                                Color("Green")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                // blurring...
                                    .blur(radius: 5)
                                // Making little big...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                                
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Green") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom,-10)
            // 创建一个 NavigationLink，用于在 isGameCardViewActive 变为 true 时导航到 GameCard 视图
            NavigationLink(destination: GameCard(index: 0, selection: $gameCardSelection), isActive: $isGameCardViewActive) {
                EmptyView()
            }
            NavigationLink(destination: Breathe(selection: $selection), tag: 1, selection: $selection){
                EmptyView()
            }
            NavigationLink(destination: Result(), isActive: $isResultViewActive) {
                EmptyView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .showBreatheView)) { notification in
            if let userInfo = notification.userInfo, let selection = userInfo["selection"] as? Int {
                self.selection = selection
                }
            }
        .onReceive(NotificationCenter.default.publisher(for: .showResultView)) { notification in
            if let userInfo = notification.userInfo, let selection = userInfo["selection"] as? Int {
                self.selection = nil
                self.isResultViewActive = true
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Making Case Iteratable...
// Tab Cases...
enum Tab: String, CaseIterable {
    
    // Raw Value must be image Name in asset..
    case MoodSelection = "MoodSelection"
    case StartWalkation = "StartWalkation"
    case Personal = "Personal"
}
