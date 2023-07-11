
import SwiftUI

// MARK: Intro Model And Sample Intro's
struct Intro: Identifiable{
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
}

var intros: [Intro] = [
    .init(imageName: "Image 1", title: "Relaxation"),
    .init(imageName: "Image 2", title: "Vacation"),
    .init(imageName: "Image 3", title: "Meditation"),
]

// MARK: Font String's
let sansBold = "WorkSans-Bold"
let sansSemiBold = "WorkSans-SemiBold"
let sansRegular = "WorkSans-Regular"
// MARK: Dummy Text
let dummyText = "See yourself in the walk."
