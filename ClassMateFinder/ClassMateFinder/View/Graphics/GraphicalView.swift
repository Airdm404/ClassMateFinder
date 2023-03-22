//
//  GraphicalView.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 3/19/23.
//

import SwiftUI

struct GraphicalView: View {
    @Binding var showGraphicalView: Bool
    @Binding var angle: Double
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            Color.black
            .edgesIgnoringSafeArea(.all)
            
            AnimatedImage()
                .offset(y:-100)
            
            HStack {
                Speaker()
                    .offset(y: 320)
                
                VStack {
                    VinylRecord()
                        .offset(y: 200)
                    
                    Text("6 O'Clock")
                        .bold()
                        .foregroundColor(.red)
                        .font(.custom("Avenir Heavy", size: 20))
                        .shadow(color: .black, radius: 3, x: 0, y: 0)
                        .shadow(color: .red, radius: 15, x: 5, y: -3)
                        .scaleEffect(isAnimating ? 1.5 : 1)
                        .offset(y: 240)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                                self.isAnimating = true
                            }
                        }
                }
            
                Speaker()
                    .offset(y: 320)
            }
    
            VStack{
                Lights()
                    .offset(y: -280)
            }
        }
        .frame(width: 400, height: 900)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .onTapGesture {
            withAnimation(.linear(duration: 0.6)) {
                angle -= 180
                showGraphicalView.toggle()
            }
        }
    }
}

struct GraphicalView_Previews: PreviewProvider {
    @State static var showGraphic: Bool = true
    @State static var angles: Double = 5
    static var previews: some View {
        GraphicalView(showGraphicalView: $showGraphic, angle: $angles)
    }
}
