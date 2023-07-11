//
//  Navigation.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//

import SwiftUI

struct Navigation: View {
    @Binding var selection: Int?

    var body: some View {
    /*    VStack {
            Text("This is the Navigation view")
            Button("Go to Map View") {
                selection = 2
            }
            .padding()
        }*/
        NavigationViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}


struct Navigation_Previews: PreviewProvider {
    @State static var selection: Int? = 1
    
    static var previews: some View {
        Navigation(selection: $selection)
    }
}
