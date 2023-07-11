//
//  ContentView.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//

import SwiftUI

struct ContentView: View {
    // Intro Status..
    @AppStorage("introShown") var introShown: Bool = false
    // Log Status..
    @AppStorage("log_Status") var log_Status: Bool = false
    
    @State private var isGameCardViewActive = false
    @State private var currentProgress = 0
    @EnvironmentObject private var urlHandler: URLHandler
    
    var body: some View {
        Group {
            if !introShown {
                IntroView()
            } else if log_Status {
                NavigationView {
                    MainPage(isGameCardViewActive: $isGameCardViewActive)
                        .onReceive(NotificationCenter.default.publisher(for:.showGameCardView)) { _ in
                            isGameCardViewActive = true
                        }
                }
            } else {
                OnBoardingPage()
            }
        }
    }
}

// 定義一個 UIViewControllerRepresentable 的結構
//繪製圍欄，圖標，自定義地圖
struct NavigationViewControllerWrapper: UIViewControllerRepresentable {
    // 定義一個 updateUIViewController 方法
    func updateUIViewController(_ uiViewController: NavigationViewController, context: Context) {
        // 可以在這裡更新 UIViewController 的屬性或方法
        
    }
    
    // 定義一個 makeUIViewController 方法
    func makeUIViewController(context: Context) -> NavigationViewController {
        return NavigationViewController()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
