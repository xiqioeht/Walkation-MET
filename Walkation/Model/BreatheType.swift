
import SwiftUI

// MARK: Type Model And Sample Types
struct BreatheType: Identifiable,Hashable{
    var id: String = UUID().uuidString
    var title: String
    var color: Color
}

let sampleTypes: [BreatheType] = [
    .init(title: "Breathe", color: .white),
]
