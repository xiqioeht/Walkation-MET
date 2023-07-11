//
//  RouteSelection.swift
//  Walkation
//
//  Created by Theoxiqi on 2023/6/29.
//


import SwiftUI

struct RouteSelection: View {
    // MARK: Animated View Properties
    @State var currentIndex: Int = 0
    @State var currentTab: String = "City Parks"
    
    // MARK: Detail View Properties
    @State var detailPark: Park?
    @State var showDetailView: Bool = false
    // FOR MATCHED GEOMETRY EFFECT STORING CURRENT CARD SIZE
    @State var currentCardSize: CGSize = .zero
    
    // Environment Values
    @Namespace var animation
    @Environment(\.colorScheme) var scheme

    @Binding var selection: Int?

    var body: some View {
      /*  ZStack{
            // BG
            BGView()
            
            // MARK: Main View Content
            VStack{
                
                // Custom Nav Nar
                NavBar.padding(.top,50)
                
                // Check out the Snap Carousel Video
                // Link in Description
                SnapCarousel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: Parks) { Park in
                    
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        Image(Park.Detail)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: Park.id, in: animation)
                            .onTapGesture {
                                currentCardSize = size
                                detailPark = Park
                                withAnimation(.easeInOut){
                                    showDetailView = true
                                }
                            }
                    }
                }
                // Since Carousel is Moved The current Card a little bit up
                // Using Padding to Avoid the Undercovering the top element
                .padding(.top,50)
                
                HStack{
                    
                    Spacer()
                    
                    Button("See More"){}
                        .font(.system(size: 16, weight: .semibold))
                        .offset(y:20)
                        .foregroundColor(.white)
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(Parks.indices) { index in
                            ZStack {
                                Image(Parks[index].Detail)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 150)
                                    .cornerRadius(15)
                                    .offset(x: -90, y: -30)
                                
                                RoundedRectangle(cornerRadius: 15)
                                                    .foregroundColor(Color.white.opacity(0.3))
                                                    .blur(radius: 1)
                                                    .frame(width: 270, height: 150)
                                                    .overlay(
                                                        VStack(spacing: 8) {
                                                            Text(index == 0 ? "West Kowloon Park" : index == 1 ? "Kowloon Park" : "Waterfront Park")
                                                                .foregroundColor(.black)
                                                                .font(.headline)
                                                                .offset(x: 30)
                                                            
                                                            Text(index == 0 ? "The Art Park is an urban\noasis with a spacious lawn" : index == 1 ? "Kowloon's ace park with\na long history" : "Waterfront promenade\nwith views of the skyline")
                                                                .foregroundColor(.black)
                                                                .font(.caption)
                                                                .offset(x: 30)
                                                            HStack(spacing: 10) {
                                                                Button(action: {
                                                                    // Button action
                                                                }) {
                                                                    RoundedRectangle(cornerRadius: 15)
                                                                        .frame(width: 60, height: 30)
                                                                        .foregroundColor(Color("Greenw"))
                                                                        .overlay(
                                                                            HStack(spacing: 4) {
                                                                                Image(systemName: "star.fill")
                                                                                    .foregroundColor(.white)
                                                                                    .font(.caption)
                                                                                Text(index == 0 ? "4.7" : index == 1 ? "4.5" : "4.3")
                                                                                    .foregroundColor(.white)
                                                                                    .font(.headline)
                                                                            })
                                                                        .offset(x: 30)
                                                                }
                                                                
                                                                Button(action: {
                                                                    // Button action
                                                                }) {
                                                                    RoundedRectangle(cornerRadius: 15)
                                                                        .frame(width: 80, height: 30)
                                                                        .foregroundColor(Color("Greenw"))
                                                                        .overlay(
                                                                            HStack(spacing: 4) {
                                                                                Text("open")
                                                                                    .foregroundColor(.white)
                                                                                    .font(.headline)
                                                                                Image(systemName: "arrow.right")
                                                                                        .foregroundColor(.white)
                                                                                        .font(.caption)
                                                                            })
                                                                                
                                                                        .offset(x: 30)
                                                                }
                                                            }
                                                        }
                                                    )
                                                    .padding(8)
                                                    .opacity(0.8)
                            }
                        }
                    }
                    .padding(30)
                }
                .zIndex(1)
            }
            if showDetailView, let detailPark = detailPark {
                DetailView(Park: detailPark, showDetailView: $showDetailView, detailPark: $detailPark, currentCardSize: $currentCardSize, selection: $selection, animation: animation)
            }
        }
        .ignoresSafeArea()*/
        NavigationViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
    
    // NavBar computed property
    var NavBar: some View {
        HStack(spacing: 0){
            ForEach(["City Parks","Country Parks"],id: \.self){tab in
                Button {
                    withAnimation{
                        currentTab = tab
                    }
                } label: {
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background{
                            if currentTab == tab{
                                Capsule()
                                    .fill(.regularMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                }
            }
        }
        .padding()
    }
    
    // MARK: Blurred BG
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let size = proxy.size

            // Unified "map.png" as the background
            Image("map")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()

            // Custom Gradient
            LinearGradient(colors: [
                Color.white.opacity(0),
                Color.white.opacity(0),
                Color.white.opacity(0),
                Color.white.opacity(0),
                Color.white.opacity(0),
                Color.white.opacity(0),
                Color.white.opacity(0),
                Color.white.opacity(0),
                Color.white.opacity(0.3),
                Color.white.opacity(0.5),
                Color.white.opacity(0.7),
                Color.white.opacity(1.0)
            ], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct RouteSelection_Previews: PreviewProvider {
    @State static var selection: Int? = 0

    static var previews: some View {
        RouteSelection(selection: $selection)
            .preferredColorScheme(.dark)
    }
}
