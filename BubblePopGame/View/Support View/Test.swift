import SwiftUI

struct InstructionsView2: View {
    let bubbleInfo: [(color: Color, points: Int, description: String)] = [
        (.red, 1, "Worth 1 point"),
        (.pink, 2, "Worth 2 points"),
        (.green, 5, "Worth 5 points"),
        (.blue, 8, "Worth 8 points"),
        (.black, 10, "Most rare, worth 10 points")
    ]

    var body: some View {
        ZStack {
            // Background with soft gradient and gentle aesthetics
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.6), .blue.opacity(0.3), .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    Text("How to Play BubblePop")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    instructionStep(number: "1", text: "Tap on bubbles to pop them and earn points.")
                    instructionStep(number: "2", text: "Each color has a different point value.")
                    instructionStep(number: "3", text: "Pop bubbles of the same color in a row to get combo points.")
                    instructionStep(number: "4", text: "You have 60 seconds per round. Be quick!")

                    bubblePointsView
                    
                    Spacer(minLength: 50)

                    startGameButton
                }
                .padding()
            }
        }
    }

    var bubblePointsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Bubble Points:")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 5)

            ForEach(bubbleInfo, id: \.color) { info in
                HStack {
                    Circle()
                        .fill(info.color)
                        .frame(width: 30, height: 30)
                        .shadow(radius: 10)
                    Text("\(info.description) (\(info.points) points)")
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                }
                //.padding(.top, 2)
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(12)
        .shadow(radius: 5)
    }

    var startGameButton: some View {
        Button(action: {
            // Start game action
        }) {
            Text("Start Game")
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }

    @ViewBuilder
    func instructionStep(number: String, text: String) -> some View {
        HStack(alignment: .top) {
            Text("\(number).")
                .font(.title)
                .foregroundColor(.yellow)
                .bold()
            Text(text)
                .font(.title3)
                .foregroundColor(.white)
                .padding(.leading, 5)
        }
        .padding(5)
        .background(Color.black.opacity(0.4))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


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


struct InstructionsView2_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView2()
    }
}
