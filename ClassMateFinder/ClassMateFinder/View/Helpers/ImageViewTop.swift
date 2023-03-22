//
//  CircleImage.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct ImageViewTop: View {
    @EnvironmentObject var dataModel: DataModel
    var dukePerson: DukePerson
    var body: some View {
        ZStack(alignment: Alignment.bottomLeading) {
            Image(uiImage: imageFromString(dukePerson.picture))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400 ,height: 390)
                .cornerRadius(15)
                .shadow(radius: 5)
            
            
            VStack(alignment: .leading) {
                HStack {
                    GenderIcon(gender: dukePerson.gender)
                        .padding(.horizontal, 3)
                    Text("\(dukePerson.fName) \(dukePerson.lName)")
                        .font(.headline)
                        .padding(.horizontal, -10)
                }
                .padding(.bottom, -5)
               
                HStack {
                    LocationIcon()
                        .padding(.horizontal, 4)
                    Text(dukePerson.from != "" ? dukePerson.from : "Unknown")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, -2)
                }
                .padding(.horizontal, 9)
                .padding(.bottom, 30)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 5)
        }
        .frame(width: 400 ,height: 400)
    }
}

struct ImageViewTop_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewTop(dukePerson: dataExample[0])
            .environmentObject(DataModel())
    }
}
