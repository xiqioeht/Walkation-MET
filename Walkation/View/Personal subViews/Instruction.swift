//
//  Instruction.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/7/4.
//

import SwiftUI

struct Instruction: View {
    @Binding var showInstruction: Bool
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.gray.opacity(0.5))
                .frame(width: 200, height: 150)
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                            Spacer()
                            
                            Text("Press and drag to\n    move the role")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.down")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .padding()
                )
            
            Button(action: {
                self.showInstruction = false
            }) {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding()
                    .frame(width: 50, height: 30)
                    .background(Color("Greenw").opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.bottom, 20)
            .offset(x: 55, y: -60)
        }
    }
}

struct Instruction_Previews: PreviewProvider {
    static var previews: some View {
        Instruction(showInstruction: .constant(true))
    }
}

