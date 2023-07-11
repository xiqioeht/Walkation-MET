//
//  WalkationApp.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//

import SwiftUI

@main
struct WalkationApp: App {
    @StateObject private var urlHandler = URLHandler()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(urlHandler)
                .onChange(of: ScenePhase.active) { _ in
                    urlHandler.validatePendingURL()
                }
                .onOpenURL { url in
                    urlHandler.handleIncomingURL(url: url)
                }
        }
    }
}
