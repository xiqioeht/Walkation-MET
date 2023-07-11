
import SwiftUI

// MARK: Walkie Model With Sample Data
struct Walkie: Identifiable{
    var id: UUID = .init()
    var imageName: String
    var title: String
    var Detail: String
}

var Walkies: [Walkie] = [
    .init(imageName: "Walkie 1", title: "Gnome", Detail: "The name Gnome means 'knowledge', he is very lively and has a great sense of humour, likes to joke around and has very good eyesight."),
    .init(imageName: "Walkie 2", title: "Idun", Detail: "Idun looks after the fruit of rejuvenation. It is lively, full of life and brings hope and good luck."),
    .init(imageName: "Walkie 3", title: "Eir", Detail: "It represents the 'hope of life', and its proximity to people gives them a sense of kindness and affection, and brings good luck and life to things."),
    .init(imageName: "Walkie 4", title: "Skadi", Detail: "Skadi loves winter and snow, loves hunting in the forest and is independent, strong, self-motivated and uncompromising."),
    .init(imageName: "Walkie 5", title: "Thrud", Detail: "It gives a first impression of greatness, practicality, beauty and means 'strength'."),
    .init(imageName: "Walkie 6", title: "Sylph", Detail: "Sylph is the spirit of the wind, and it is said that the breeze is its whisper. The world also believes that all spirits of pure heart become Sylph."),
    .init(imageName: "Walkie 7", title: "Yuder", Detail: "Yuder is one of the Fate Spirits, whose name means 'dream weaver', in charge of the past time, with a gentle, calm and light-hearted power."),
    .init(imageName: "Walkie 8", title: "Nanna", Detail: "Nanna is a beautiful and delicate spirit, meaning 'flower in bloom', and is fragrant wherever it goes."),
]
