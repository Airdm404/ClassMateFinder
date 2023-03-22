//
//  LanguageBox.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/16/23.
//

import SwiftUI

struct LanguageBox: View {
    var langName: String
    var body: some View {
        ZStack(alignment: Alignment.center) {
            Rectangle()
                .fill(Color(hue: 0.621, saturation: 1.0, brightness: 1.0, opacity: 0.178))
                .frame(width: 100 ,height: 32)
                .cornerRadius(35)
            
            Text("\(langName)")
                .font(.custom("Helvitica", size: 12))
                .padding(.leading, 5)
    
        }
        .frame(width: 100 ,height: 32)
        .background(Color.white)
        .cornerRadius(35)
        .shadow(radius: 5)
        
        
    }
}

struct LanguageBox_Previews: PreviewProvider {
    static var langa = "Javascript"
    static var previews: some View {
        LanguageBox(langName: langa)
    }
}
