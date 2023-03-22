//
//  LocationIcon.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct LocationIcon: View {
    var body: some View {
        Image("loc")
            .resizable()
            .frame(width: 12, height: 17)
        
         
    }
}

struct LocationIcon_Previews: PreviewProvider {
    static var previews: some View {
        LocationIcon()
    }
}
