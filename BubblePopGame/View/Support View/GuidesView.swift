import SwiftUI

struct InstructionsView: View {
    
    let bubbleInfo: [(color: Color, points: Int, description: String)] = [
        (.red, 1, " =  1 PTS"),
        (pink, 2, " =  2 PTS"),
        (.green, 5, " =  5 PTS"),
        (.blue, 8, " =  8 PTS"),
        (.black, 10, " =  10 PTS")
    ]

    var body: some View {
        ZStack {
            // Background with gradient and floating bubbles
//            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .white]), startPoint: .top, endPoint: .bottom)
//                .edgesIgnoringSafeArea(.all)
            
            Image("GuidlineBG")
                .resizable()
                //.scaledToFill()
                .edgesIgnoringSafeArea(.all) // Extends the content to the edges of the screen

            VStack(spacing: 20) {
                
                guide_Label
                
                VStack(alignment: .leading, spacing: 10) {
                    guideView
                    bubblePoints_View
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(12)
                
                startGameButton

            }
            .padding()
        }
    }
    
    // MARK: - SUBVIEWS

    var bubblePoints_View: some View {
        
        //  USING GEOMETRY ALLOW the font size to dynamically adjust to dif screen dimensions >> MAKING APP's UI more flexible & adaptable to various devices
        GeometryReader {
            geometry in  VStack (alignment: .leading, spacing: 8) {
                
                let UIwidth = geometry.size.width
                let UIHeight = geometry.size.height
                
                //  HEADING
                Text("Bubble Point")
                    .font(.custom("CutneyPersonalUse", size: UIwidth * 0.11)) // EASIER TO CHANGE DEVICES
                    .frame(width: UIwidth, height: UIHeight * 0.20, alignment: .center)
                    .foregroundStyle(blue_Gradient)
                    .padding(.vertical, 5)
                    .padding(.bottom, -18)
                
                //  APPEAR BUBBLES'S List SCORE
                ForEach(bubbleInfo, id: \.color) { info in
                    HStack {
                        Circle()
                            .foregroundStyle(radialGradientForBubble(info.color, bubbleSize: 100))
                            //.fill(info.color)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .blur(radius: 5)
                                    .offset(x: -1, y: -2)
                                //.frame(width: bubble.size - 5)
                            )
                            .frame(width: UIwidth * 0.25, height:  UIHeight * 0.13) //width: UIwidth * 0.15, height:  UIHeight * 0.13
                            .shadow(radius: 10)
                        
                        Text("\(info.description) (\(info.points))")
                            .font(.custom("MarkerFelt-Wide", size: UIwidth * 0.06))
                            .foregroundStyle(.white)
                            .padding(.leading, -20)
                    }
                }
                
            } // VSTACK E.
            .padding(.bottom, 10)
            .background(Color.black.opacity(0.5))
            .cornerRadius(12)
            .shadow(radius: 5)
        
        } // GEO E.
        
    }
    
    var guide_Label: some View {
        Text("How to Play")
            .font(.custom("InflatePTx-Chrome", size: 60))
            .multilineTextAlignment(.center)
            .lineSpacing(8)
    }
    
    var guideView: some View {
        
        VStack (alignment: .leading, spacing: 5) {
            
            HStack(alignment: .top) {
                Image(systemName: "1.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title)
                Text("Tap on bubbles to pop them and earn points.")
                    //.font(.title3)
            }
            
            HStack(alignment: .top) {
                Image(systemName: "2.circle.fill")
                    .foregroundColor(.green)
                    .font(.title)
                Text("Each color has a different point value. See below for details.")
                    //.font(.title3)
            }
            
            HStack(alignment: .top) {
                Image(systemName: "3.circle.fill")
                    .foregroundColor(.red)
                    .font(.title)
                Text("Pop bubbles of the same color in a row to get combo points.")
                    //.font(.title3)
            }

            HStack(alignment: .top) {
                Image(systemName: "4.circle.fill")
                    .foregroundColor(.purple)
                    .font(.title)
                Text("You have 60 seconds per round. Be quick!")
                    //.font(.title3)
            }
            
        }
        .foregroundStyle(purple_yellow_Gradient)
        .fontWeight(.medium)
        .font(.custom("MarkerFelt-Wide", size: 20))
        
    }
    
    //  GAME BUTTON
    var startGameButton: some View {
        
            
            VStack {
                
                Button(action: {
                    // Start game action
                }) {
                    Text("Start Game")
                        .font(.custom("CutneyPersonalUse", size: 36)) // EASIER TO CHANGE DEVICES
                        .bold()
                        //.frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18.0)
                                .stroke(.white, lineWidth: 2.5) // Specify the color and width of the border here
                        )
                        .shadow(radius: 5)
                }
            }//VSTACK E.
                    
    }
    
    // MARK: - FUNCTION
    
    //  BUBBLE COLORING
    func radialGradientForBubble(_ bubbleColor: Color, bubbleSize: CGFloat) -> RadialGradient {
        RadialGradient(
            gradient: Gradient(stops: [
                .init(color: .white, location: 0.13), //0.3
                .init(color: bubbleColor, location: 0.20),
                .init(color: .yellow, location: 0.4),
                .init(color: bubbleColor, location: 0.4),
                .init(color: .yellow, location: 0.15),
                
            ]),
            center: .topTrailing, // .topleading
            startRadius: bubbleSize * -0.1,
            endRadius: bubbleSize * 1.1 //1
        )
    }
}

// MARK: - PREVIEW

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
