//
//  StartWalkation.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//

import SwiftUI

struct StartWalkation: View {
    // 0 for RouteSelection, 1 for Navigation, 2 for Map, 3 for Game
    @State private var selection: Int? = 0

    var body: some View {
        VStack {
            if selection == 0 {
                RouteSelection(selection: $selection)
            } else if selection == 1 {
                Navigation(selection: $selection)
            } else if selection == 2 {
                Map(selection: $selection)
            } else if selection == 3 {
                Game(selection: $selection)
            } else if selection == 4 {
                Badge(selection: $selection)
            } else if selection == 5 {
                Result()
            } else if selection == 6 {
                EnergyCollection(selection: $selection)
            } else if selection == 7 {
                Breathe(selection: $selection)
            }
        }
    }
}




struct StartWalkation_Previews: PreviewProvider {
    static var previews: some View {
        StartWalkation()
    }
}
