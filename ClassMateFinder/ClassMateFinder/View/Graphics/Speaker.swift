//
//  Speaker.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 3/19/23.
//

import SwiftUI

struct Speaker: View {
    @State private var circleScale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            Path { path in
                path.addRoundedRect(in: CGRect(x: width * 0.1, y: height * 0.1, width: width * 0.8, height: height * 0.8), cornerSize: CGSize(width: width * 0.05, height: height * 0.05))
                
                path.addRoundedRect(in: CGRect(x: width * 0.15, y: height * 0.15, width: width * 0.7, height: height * 0.7), cornerSize: CGSize(width: width * 0.04, height: height * 0.04))
            }
            .fill(Color.black)
            .shadow(color: .white, radius: 10)
            
            Circle()
                .fill(Color.yellow)
                .frame(width: width * 0.33 * circleScale, height: height * 0.33 * circleScale)
                .offset(x: width * 0.34 * circleScale, y: height * 0.15 * circleScale)
            
            Circle()
                .fill(Color.black)
                .frame(width: width * 0.1 * circleScale, height: height * 0.1 * circleScale)
                .offset(x: width * 0.45 * circleScale, y: height * 0.26 * circleScale)
            
            Circle()
                .fill(Color.yellow)
                .frame(width: width * 0.4 * circleScale, height: height * 0.4 * circleScale)
                .offset(x: width * 0.3 * circleScale, y: height * 0.5 * circleScale)
            
            Circle()
                .fill(Color.black)
                .frame(width: width * 0.1 * circleScale, height: height * 0.1 * circleScale)
                .offset(x: width * 0.45 * circleScale, y: height * 0.65 * circleScale)
        }
        .frame(width: 100, height: 150)
        .onAppear {
            let animation = Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)
            withAnimation(animation) {
                circleScale = 1.1
            }
        }
    }
}

struct Speaker_Previews: PreviewProvider {
    static var previews: some View {
        Speaker()
    }
}
