//
//  MovieIcon.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct MovieIcon: View {
    var dukePerson: DukePerson
    var body: some View {
        ZStack(alignment: Alignment.center) {
            Rectangle()
                .fill(Color(hue: 0.621, saturation: 1.0, brightness: 1.0, opacity: 0.178))
                .frame(width: 140 ,height: 32)
                .cornerRadius(35)
            
            
            
            HStack {
                Image("movie")
                    .resizable()
                    .frame(width: 17, height: 20)
                    .padding(.horizontal, -5)
                
                
                Text("\(dukePerson.movie)")
                    .font(.custom("Helvitica", size: 11))
                    .padding(.leading, 5)
                    
            }
            .padding(.horizontal, 10)
            
            

        }
        .frame(width: 140 ,height: 32)
        .background(Color.white)
        .cornerRadius(35)
        .shadow(radius: 5)
        
    }
}

struct MovieIcon_Previews: PreviewProvider {
    static var previews: some View {
        MovieIcon(dukePerson: dataExample[5])
    }
}
