//
//  Map.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//

import SwiftUI

struct Map: View {
    @Binding var selection: Int?

    var body: some View {
        VStack {
            Text("This is the Map view")
            
            Button("Go to Game View") {
                selection = 3
            }
            .padding()
            
            Button("Go to EnergyCollection View") {
                selection = 6
            }
            .padding()
            
            Button("Go to Breathe View") {
                selection = 7
            }
            .padding()
        }
    }
}


struct Map_Previews: PreviewProvider {
    @State static var selection: Int? = 2
    static var previews: some View {
        Map(selection: $selection)
    }
}
