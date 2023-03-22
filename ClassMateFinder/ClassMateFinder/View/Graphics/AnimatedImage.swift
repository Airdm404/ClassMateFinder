//
//  AnimatedImage.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 3/19/23.
//

import SwiftUI

struct AnimatedImage: View {
    @State private var isAnimating = false
    @State private var blurRadius: CGFloat = 0
    @State private var scale: CGFloat = 1
    
    var body: some View {
        ZStack {
            Image("monkey")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: 27)
                .colorMultiply(isAnimating ? .black : .white)
                .blur(radius: blurRadius)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 3.0).repeatForever()) {
                        isAnimating = true
                        blurRadius = 4
                        scale = 0.8
                    }
                }
        }

    .frame(width: 650, height: 650)
        

    }
}

struct AnimatedImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedImage()
    }
}
