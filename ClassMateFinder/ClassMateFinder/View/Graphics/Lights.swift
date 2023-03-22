//
//  Lights.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 3/19/23.
//

import SwiftUI

struct Lights: View {
    var body: some View {
        HStack{
            VStack {
                LightView(color: .red)
            }
            
            VStack {
                LightView(color: .purple)
                    .offset(y: -40)
            }
            
            VStack {
                LightView(color: .green)
                    .offset(y: 15)
            }
            
            VStack {
                LightView(color: .blue)
                    .offset(y: -40)
            }
            
            VStack {
                LightView(color: .indigo)
                    .offset(y: 0)
            }
        }
    }
}

struct Lights_Previews: PreviewProvider {
    static var previews: some View {
        Lights()
    }
}
