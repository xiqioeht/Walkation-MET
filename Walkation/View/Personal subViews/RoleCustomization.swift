//
//  RoleCustomization.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/7/4.
//

import SwiftUI

struct RoleCustomization: View {
    
    @State var Roles: [Role] = [
        Role(CharacterName: "Character_1", toppings: [Topping(toppingName: "Scene_0")]),
        Role(CharacterName: "Character_2", toppings: [Topping(toppingName: "Scene_0")]),
        Role(CharacterName: "Character_3", toppings: [Topping(toppingName: "Scene_0")]),
        Role(CharacterName: "Character_4", toppings: [Topping(toppingName: "Scene_0")]),
        Role(CharacterName: "Character_5", toppings: [Topping(toppingName: "Scene_0")]),
        Role(CharacterName: "Character_6", toppings: [Topping(toppingName: "Scene_0")]),
        Role(CharacterName: "Character_7", toppings: [Topping(toppingName: "Scene_0")]),
        Role(CharacterName: "Character_8", toppings: [Topping(toppingName: "Scene_0")])
    ]
    @State var showInstruction = true

    @State var currentRole: String = "Character_1"
    @State var roleSize: CGFloat = 1.0  // Variable for role size
    @State var xOffset: CGFloat = 0.0  // Variable for x-axis offset
    @State var yOffset: CGFloat = 0.0  // Variable for y-axis offset
    @State var isDragging = false  // Flag to track if a character is being dragged
    @State var dragPosition = CGSize.zero  // Position offset for the dragged character
    
    // To add smooth slide effect...
    @Namespace var animation
    
    let toppings: [String] = ["Scene_0", "Scene_1", "Scene_2", "Scene_3", "Scene_4", "Scene_5", "Scene_6", "Scene_7", "Scene_8", "Scene_9", "Scene_10", "Scene_11"]
    
    var body: some View {
        
        VStack{
            
            // Role View...
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack {
                    VStack {
                        ZStack {
                            ForEach(Roles.indices) { index in
                                if Roles[index].CharacterName == currentRole {
                                    ToppingsView(toppings: Roles[index].toppings, Role: Roles[index], width: (size.width / 2) - 45)
                                        .offset(x: 5, y: 10)
                                    
                                    Image(Roles[index].CharacterName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaleEffect(roleSize)
                                        .padding(40)
                                        .offset(x: xOffset, y: yOffset)
                                        .gesture(
                                            LongPressGesture(minimumDuration: 0.3)
                                                .sequenced(before: DragGesture(minimumDistance: 0))
                                                .onChanged { value in
                                                    switch value {
                                                    case .second(true, let drag?):
                                                        isDragging = true
                                                        let proposedXOffset = drag.startLocation.x + drag.translation.width - UIScreen.main.bounds.width / 2.5
                                                        let proposedYOffset = drag.startLocation.y + drag.translation.height - UIScreen.main.bounds.height / 6
                                                        xOffset = min(max(proposedXOffset, -UIScreen.main.bounds.width / 2.5), UIScreen.main.bounds.width / 2.5)
                                                        yOffset = min(max(proposedYOffset, -UIScreen.main.bounds.height / 6), UIScreen.main.bounds.height / 6)
                                                    default:
                                                        break
                                                    }
                                                }
                                                .onEnded { _ in
                                                    isDragging = false
                                                }
                                        )
                                        .animation(.spring(), value: isDragging)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    .frame(height: 300)
                    
                    HStack {
                        Button(action: {
                            let currentIndex = Roles.firstIndex(where: { $0.CharacterName == currentRole }) ?? 0
                            if currentIndex > 0 {
                                currentRole = Roles[currentIndex - 1].CharacterName
                            } else {
                                currentRole = Roles.last?.CharacterName ?? ""
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .opacity(0.5)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                        }.padding(.leading)

                        Spacer()

                        Button(action: {
                            let currentIndex = Roles.firstIndex(where: { $0.CharacterName == currentRole }) ?? 0
                            if currentIndex < Roles.count - 1 {
                                currentRole = Roles[currentIndex + 1].CharacterName
                            } else {
                                currentRole = Roles.first?.CharacterName ?? ""
                            }
                        }) {
                            Image(systemName: "arrow.right")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .opacity(0.5)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                        }
                        .padding(.trailing)
                    }
                }
            }
            .overlay(
                Group {
                    if showInstruction {
                        Instruction(showInstruction: $showInstruction)
                    }
                }
            )
            
            ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), showsIndicators: false) {
                
                Group{
                    
                    CustomToppings()
                    
                    Text("Role size")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading)
                        .offset(y: -60)
                    
                    // Role size slider...
                    Slider(value: $roleSize, in: 0.5...1.5, step: 0.001)
                        .padding(.horizontal)
                        .accentColor(Color("Green"))
                        .offset(y: -60)
                    
                    HStack {
                        VStack {
                            Text("X Axis")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)

                            // X Offset slider...
                            Slider(value: $xOffset, in: -100...100, step: 0.01)
                                .padding(.horizontal)
                                .accentColor(Color("Green"))
                        }

                        VStack {
                            Text("Y Axis")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)

                            // Y Offset slider...
                            Slider(value: $yOffset, in: -100...100, step: 0.01)
                                .padding(.horizontal)
                                .accentColor(Color("Green"))
                        }
                    }
                    .offset(y: -60)

                    // Add to cart Button...
                    Button(action: {
                        // Handle button click event here
                    }) {
                    /*    HStack(spacing: 15){
                            Text("Save")
                                .fontWeight(.semibold)
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color("Yellow"))
                        }
                        .foregroundColor(.white)
                        .padding(.vertical,12)
                        .padding(.horizontal,30)
                        .background(Color("Green"),in: RoundedRectangle(cornerRadius: 15))*/
                    }
                    .offset(y: -30)
                }
                .padding(.top,50)
            }

        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if isDragging {
                        xOffset = dragPosition.width + gesture.translation.width
                        yOffset = dragPosition.height + gesture.translation.height
                    }
                }
                .onEnded { _ in
                    dragPosition = .zero
                }
        )
    }

    @ViewBuilder
    func CustomToppings() -> some View {
        
        Group{
            
            // Custom Toppings...
            Text("Scene")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading)
                .offset(y: 10)
            
            ScrollViewReader { proxy in
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: -10) {
                        
                        ForEach(toppings, id: \.self) { topping in
                            
                            // Displaying topping Image...
                            Image(topping)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding(12)
                                .background(
                                    Color.green
                                        .clipShape(Circle())
                                        .opacity(isAdded(topping: topping) ? 0.15 : 0)
                                        .animation(.easeInOut, value: currentRole)
                                )
                                .padding()
                                .contentShape(Circle())
                                .onTapGesture {
                                    // Get index for current character
                                    let currentCharacterIndex = getIndex(CharacterName: currentRole)
                                    
                                    // Keep track of previous topping
                                    Roles[currentCharacterIndex].previousTopping = Roles[currentCharacterIndex].currentTopping
                                    
                                    // Clear previous toppings...
                                    Roles[currentCharacterIndex].toppings.removeAll()
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        // Add the new topping...
                                        let toppingObject = Topping(toppingName: topping)
                                        Roles[currentCharacterIndex].toppings.append(toppingObject)
                                        Roles[currentCharacterIndex].currentTopping = toppingObject

                                        // Mark the topping as added after a small delay
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation {
                                                Roles[currentCharacterIndex].toppings[0].isAdded = true
                                            }
                                        }
                                    }
                                }

                                .tag(topping)
                        }
                    }
                }
                .onChange(of: currentRole) { _ in
                    withAnimation{
                        proxy.scrollTo(toppings.first ?? "", anchor: .leading)
                    }
                }
            }
        }
        .offset(y: -50)
    }


    
    func isAdded(topping: String)->Bool{
        
        let status = Roles[getIndex(CharacterName: currentRole)].toppings.contains { currentTopping in
            return currentTopping.toppingName == topping
        }
        
        return status
    }
    
    func getIndex(CharacterName: String)->Int{
        
        let index = Roles.firstIndex { Role in
            return Role.CharacterName == CharacterName
        } ?? 0
        
        return index
    }
    
    @ViewBuilder
    func ToppingsView(toppings: [Topping], Role: Role, width: CGFloat) -> some View {
        Group {
            ForEach(toppings.indices, id: \.self) { index in
                let topping = toppings[index]
                ZStack {
                    // Displaying only the first image of each topping, with no rotation
                    Image("\(topping.toppingName)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .scaleEffect(topping.isAdded ? 7 : 1, anchor: .center)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                                withAnimation {
                                    Roles[getIndex(CharacterName: Role.CharacterName)].toppings[index].isAdded = true
                                }
                            }
                        }
                }
            }
        }
    }
}

struct RoleCustomization_Previews: PreviewProvider {
    static var previews: some View {
        RoleCustomization()
    }
}

