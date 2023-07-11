
import SwiftUI

struct Park: Identifiable{
    var id = UUID().uuidString
    var ParkTitle: String
    var Detail: String
}

var Parks: [Park] = [

    Park(ParkTitle: "West Kowloon Park", Detail: "park1"),
    Park(ParkTitle: "Kowloon Park", Detail: "park2"),
    Park(ParkTitle: "Waterfront Park", Detail: "park3"),

]

// MARK: Dummy Text
var sampleText = "Kowloon Park: Nestled in the bustling district of Tsim Sha Tsui, Kowloon Park is a haven of tranquility amid the urban chaos. Spanning over 33 acres, the park blends nature and culture seamlessly, boasting beautifully landscaped gardens, meandering pathways, and a large artificial lake. Visitors can explore its aviary, which houses a wide variety of exotic birds, or relax in the Chinese Garden, complete with traditional pavilions and a lotus pond. Kowloon Park is a popular destination for families, nature enthusiasts, and those seeking a peaceful escape."
