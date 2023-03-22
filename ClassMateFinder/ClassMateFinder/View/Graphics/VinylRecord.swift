//
//  VinylRecord.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 3/19/23.
//

import SwiftUI

struct VinylRecord: View {
    @State private var rotationAngle: Angle = .degrees(0)
    @State private var shadowColor: Color = .white
    @State private var colors: [Color] = [.red, .blue, .green, .orange, .purple, .teal, .cyan, .pink, .white]
    @State private var colorIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width - 10
            let height = geometry.size.height - 10
            let minDimension = min(width, height)

            ZStack {
                Circle()
                    .stroke(lineWidth: minDimension * 0.05)
                    .frame(width: minDimension, height: minDimension)
                    .shadow(color: shadowColor, radius: 5, x: 2, y: 2)
                
                Circle()
                
                Circle()
                    .fill(Color.yellow)
                    .frame(width: minDimension * 0.35, height: minDimension * 0.35)
                    
                RoundedRectangle(cornerRadius: minDimension * 0.0)
                    .stroke(lineWidth: minDimension * 0.02)
                    .frame(width: minDimension * 0.01, height: minDimension * 0.18)
                    .offset(y: -minDimension * 0.45)
                    .foregroundColor(shadowColor)


                ForEach(0..<3) { index in
                    RoundedRectangle(cornerRadius: minDimension * 0.08)
                        .frame(width: minDimension * 0.1, height: minDimension * 0.04)
                        .rotationEffect(.degrees(Double(index) * 60), anchor: .center)
                        .offset(y: -minDimension * 0.30)
                        .foregroundColor(shadowColor)
                }
            }
            .rotationEffect(rotationAngle)
            .onAppear {
                let colorChangeAnimation = Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)
                withAnimation(colorChangeAnimation) {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        colorIndex = (colorIndex + 1) % colors.count
                        shadowColor = colors[colorIndex]
                    }
                }
                let rotationAnimation = Animation.linear(duration: 5).repeatForever(autoreverses: false)
                withAnimation(rotationAnimation) {
                    rotationAngle = .degrees(360)
                }
            }
        }
        .frame(width: 180, height: 180)
    }
}

struct VinylRecord_Previews: PreviewProvider {
    static var previews: some View {
        VinylRecord()
    }
}
