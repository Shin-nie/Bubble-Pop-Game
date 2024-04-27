//
//  BubbleVieww.swift
//  TestGame
//


import SwiftUI

struct BubbleView: View {
    @Binding var bubble: Bubble
    @State var currentPosition: CGPoint
    @State private var isVisible: Bool = true // Add state to control visibility

    @State private var bubbleScale: CGFloat = 1.0 // State variable for bubble scale

    /* MARK: Callback to handle game logic related to popping  */
    var popBubbleAction: () -> Void
    
    /*  MARK: HOW TO PASS VALUE INTO VIEWMODEL
                INITIALISER DECLARE            */
    init(bubble: Binding<Bubble>, popBubbleAction: @escaping () -> Void) {
        self._bubble = bubble
        self._currentPosition = State(initialValue: bubble.wrappedValue.position)
        self.popBubbleAction = popBubbleAction
    }
    
    var body: some View {
        ZStack {// ZSTACK E.
            
            /*  TEST
             
            //  PUT THEME TO TEST HOW BUBBLE LOOK LIKE
            //Image("GameBGR")
            //.resizable()
            //.edgesIgnoringSafeArea(.all)
             
              TEST */
            
            if isVisible { //  if S. // !bubble.popped &&
                Circle()
                    .fill(radialGradientForBubble(bubble))
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                        //.frame(width: bubble.size - 5)
                    )
                    //.frame(width: bubble.size, height: bubble.size)
                    .frame(width: bubble.size * bubbleScale, height: bubble.size * bubbleScale) // Apply scale
                    //.shadow(radius: 0.3)
                    .position(currentPosition)
                    .onAppear {
                        startFloatingAnimation()
                    }
                    .onTapGesture {
                        popBubble()
                    }
            } // if E.
        }   // ZSTACK E.
        //.background(darkblue)
    }
    
    // MARK: - FUNCTIONS
    
    /* ▛▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▜
       ▌ ☾☁𐋐☀▂▃▅▇█▓▒░ ❝ 🌵𝐅 𝐔 𝐍 𝐂 𝐓 𝐈 𝐎 𝐍🌵 ❞ ░▒▓█▇▅▃▂𐋐☀☾☁  ▌
       ▙▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▟ */
    
    //  BUBBLE COLORING
    func radialGradientForBubble(_ bubble: Bubble) -> RadialGradient {
        
        RadialGradient(
            gradient: Gradient(stops: [
                .init(color: bubble.color, location: 0.2),
                //.init(color: .white, location: 0.1),
                    .init(color: .white, location: 0.2), //0.3
                .init(color: bubble.color, location: 0.5),
                .init(color: .yellow, location: 1) //1.1
            ]),
            center: .topTrailing, // .topleading
            startRadius: bubble.size * -0.1,
            endRadius: bubble.size * 1.1 //1
        )
    }
    
    //  SYNC when BUBBLES ARE POPPED
    private func popBubble() {
//        withAnimation(.easeOut(duration: 0.2)) {
//            isVisible = false // Set visibility to false to trigger the disappearing animation
//            bubbleScale = 0.01 // Scale down the bubble to almost zero
//        }
// 
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            self.popBubbleAction()  // EXECUTE the pop action after the animation
//        }
        
        withAnimation(Animation.easeOut(duration: 0.1)) {
            bubbleScale = 0.001 // Scale down the bubble
        }

        // Wait for the scaling animation to complete, then fade out
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(Animation.easeOut(duration: 0.1)) {
                isVisible = false // Fade out the bubble
            }
            // Execute the pop action after both animations complete
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.popBubbleAction()
            }
        }
    }
    
    //  FLOATING ANIMATION
    private func startFloatingAnimation() {
        
        // UIScreen.main.bounds gives the entire screen dimensions
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Calculate the maximum x and y positions while considering the radius of the bubble to keep it fully onscreen
        let maxX = screenWidth - bubble.size / 2
        let maxY = screenHeight - 200
        
        // Ensure the bubble's center doesn't move past the screen's bounds by setting a minimum of half its size
        let minX = bubble.size / 2
        let minY = bubble.size / 2
        
        // Randomly generate new positions within the adjusted bounds
        let newX = CGFloat.random(in: minX...maxX)
        let newY = CGFloat.random(in: minY...maxY)
        
        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            currentPosition = CGPoint(x: newX, y: newY)  // Animate the state property, not the model directly
            
        }
    }
}

// MARK: - Preview

// Preview provider for SwiftUI view
struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample bubble to use in the preview
        // let sampleBubble = Bubble(color: .red, points: 0, size: 100, position: CGPoint(x: 70, y: 30))
        
        let sampleBubble = Bubble(position: CGPoint(x: 70, y: 30), color: .red, colorName: "red", points: 0, probability: 0.4)
        //BubbleView(bubble: sampleBubble)
        BubbleView(bubble: .constant(sampleBubble), popBubbleAction: {})
    }
}
