//
//  GenderIcon.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct GenderIcon: View {
    var gender: Int
    var body: some View {
        switch gender {
        case 1:
            Image("male")
                .resizable()
                .frame(width: 30, height: 25)
            
        case 2:
            Image("female")
                .resizable()
                .frame(width: 30, height: 25)
        default:
            Image("other")
                .resizable()
                .frame(width: 30, height: 25)
        }
    }
}

struct GenderIcon_Previews: PreviewProvider {
    static var previews: some View {
        GenderIcon(gender: 1)
    }
}
