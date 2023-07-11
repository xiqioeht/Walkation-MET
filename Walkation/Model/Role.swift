
import SwiftUI

// Role model and sample Roles....
struct Role: Identifiable{
    var id = UUID().uuidString
    var CharacterName: String
    var toppings: [Topping] = []
    var currentTopping: Topping? = nil
    var previousTopping: Topping? = nil
}
