
import SwiftUI

struct DetailView: View {
    var Park: Park
    @Binding var showDetailView: Bool
    @Binding var detailPark: Park?
    @Binding var currentCardSize: CGSize
    @Binding var selection: Int?
    var animation: Namespace.ID
    
    @State var showDetailContent: Bool = false
    @State var offset: CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                Image(Park.Detail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentCardSize.width, height: currentCardSize.height)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: Park.id, in: animation)
                
                VStack(spacing: 15){
                    Text("Introduction")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,25)
                    
                    Text(sampleText)
                        .multilineTextAlignment(.leading)
                    
                    Button {
                        withAnimation{
                            selection = 1 // Update the selection variable when the button is clicked
                        }
                    } label: {
                        Text("Start walkation")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color("Green"))
                            )
                    }
                    .padding(.top,20)
                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 0 : 200)
            }
            .padding(.top,100)
            .padding(30)
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut){
                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            // YOUR OWN CUSTOM THERSOLD
            if newValue > 120{
                withAnimation(.easeInOut){
                    showDetailContent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut){
                        showDetailView = false
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    @State static var selection: Int? = 0

    static var previews: some View {
        RouteSelection(selection: $selection)
            .preferredColorScheme(.dark)
    }
}
