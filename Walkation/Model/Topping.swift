
import SwiftUI

// Topping Model....
struct Topping: Identifiable{
    var id = UUID().uuidString
    var toppingName: String
    var isAdded: Bool = false
    var randomToppingPostions: [CGSize] = []
}
