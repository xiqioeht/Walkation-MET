//
//  URLHandler.swift
//  Walkation
//
//  Created by MA Siqi on 6/7/2023.
//

import Foundation

class URLHandler: ObservableObject {
    @Published var pendingURL: URL?
    let correctTagSequence = ["nfc1", "nfc3", "nfc2"]
    private(set) var currentProgress = 0
    private var lastBreatheScanTime: Date?
    
    // 添加 breathDuration 属性
    var breathDuration: Double = 5.0 // 默认值，您可以根据需要更改

    func handleIncomingURL(url: URL) {
        loadBreathDurationFromUserDefaults() // 加载用户选择的呼吸时长
        pendingURL = url
        validatePendingURL()
    }

    func validatePendingURL() {
        guard let url = pendingURL else {
            return
        }

        let urlAsString = url.absoluteString

        guard urlAsString.hasPrefix("openWalkation://") else {
            print("Incorrect scheme or missing components: \(url)")
            return
        }

        let path = urlAsString.dropFirst("openWalkation://".count)
        print("Incoming URL: \(url)")
        print("Path: \(path)")

        handleIncomingPath(path: path)

        pendingURL = nil
    }
    
    private func handleIncomingPath(path: Substring) {
        switch path {
        case "gamecard":
            NotificationCenter.default.post(name: .showGameCardView, object: nil)
        case "breathe":
            if let lastScanTime = lastBreatheScanTime,
                Date().timeIntervalSince(lastScanTime) >= breathDuration {
                print(breathDuration)
                NotificationCenter.default.post(name: .showResultView, object: nil, userInfo: ["selection": 1])
            } else {
                NotificationCenter.default.post(name: .showBreatheView, object: nil, userInfo: ["selection": 1])
            }
            lastBreatheScanTime = Date()
        case "nfc1", "nfc3", "nfc2":
            processTagSequence(path: path)
        default:
            print("Unhandled path: \(path)")
        }
    }

    private func processTagSequence(path: Substring) {
        if path == correctTagSequence[currentProgress] {
            currentProgress += 1

            if currentProgress == correctTagSequence.count {
                NotificationCenter.default.post(name: .showResultView, object: nil)
                currentProgress = 0
            } else {
                NotificationCenter.default.post(name: .updateProgress, object: currentProgress)
            }
        } else {
            currentProgress = 0
        }
    }
    
    // 添加 loadBreathDurationFromUserDefaults() 方法
    func loadBreathDurationFromUserDefaults() {
        let duration = UserDefaults.standard.double(forKey: "breathDuration")
        if duration != 0 {
            breathDuration = duration
            print(breathDuration)
        }
    }
}

extension Notification.Name {
    static let showGameCardView = Notification.Name("showGameCardView")
    static let showResultView = Notification.Name("showResultView")
    static let showBreatheView = Notification.Name("showBreatheView")
    static let updateProgress = Notification.Name("updateProgress")
}
