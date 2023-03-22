//
//  LightView.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 3/19/23.
//

import SwiftUI

struct LightView: View {
    @State private var isOn = false
    var color: Color
    var body: some View {
        Image(systemName: isOn ? "music.note.fill" : "music.note")
            .resizable()
            .foregroundColor(isOn ? color : .white)
            .frame(width: 60, height: 60)
            .shadow(color: color, radius: 5 )
            .scaleEffect(isOn ? 0.8 : 0.5)
            .saturation(isOn ? 50 : 5)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    self.isOn = true
                }
            }
    }
}

struct LightView_Previews: PreviewProvider {
    static var previews: some View {
        LightView(color: .green)
    }
}
