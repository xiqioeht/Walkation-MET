
import SwiftUI

// See my Custom Snap Carousel Video...
// Link in Description...

struct SnapCarousel<Content: View,T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    // Properties...
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 15,trailingSpace: CGFloat = 100,index: Binding<Int>,items: [T],@ViewBuilder content: @escaping (T)->Content){
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    // Offset...
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
            ZStack {
                Button(action: {
                    // Action when button is pressed
                }) {
                    content(list[0])
                        .frame(width: 40, height: 50) // Adjust the size as needed
                }
                .position(x: 40, y: 20) // Position the button

                Button(action: {
                    // Action when button is pressed
                }) {
                    content(list[1])
                        .frame(width: 80, height: 120) // Adjust the size as needed
                }
                .position(x: 100, y: 160) // Position the button

                Button(action: {
                    // Action when button is pressed
                }) {
                    content(list[2])
                        .frame(width: 60, height: 80) // Adjust the size as needed
                }
                .position(x: 320, y: 300) // Position the button
            }
        }

    // Moving View based on scroll Offset...
    func getOffset(item: T,width: CGFloat)->CGFloat{
        
        // Progress...
        // Shifting Current Item to Top....
        let progress = ((offset < 0 ? offset : -offset) / width) * 60
        
        // max 60...
        // then again minus from 60....
        let topOffset = -progress < 60 ? progress : -(progress + 120)
        
        let previous = getIndex(item: item) - 1 == currentIndex ? (offset < 0 ? topOffset : -topOffset) : 0
        
        let next = getIndex(item: item) + 1 == currentIndex ? (offset < 0 ? -topOffset : topOffset) : 0
        
        // saftey check between 0 to max list size...
        let checkBetween = currentIndex >= 0 && currentIndex < list.count ? (getIndex(item: item) - 1 == currentIndex ? previous : next) : 0
        
        // checking current....
        // if so shifting view to top...
        return getIndex(item: item) == currentIndex ? -60 - topOffset : checkBetween
    }
    
    // Fetching Index...
    func getIndex(item: T)->Int{
        let index = list.firstIndex { currentItem in
            return currentItem.id == item.id
        } ?? 0
        
        return index
    }
}

struct RouteSelection_PreviewsCarousel: PreviewProvider {
    @State static var selection: Int? = 0
    
    static var previews: some View {
        RouteSelection(selection: $selection)
            .preferredColorScheme(.dark)
    }
}
