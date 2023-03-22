//
//  FilteredRow.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/24/23.
//

import SwiftUI

struct FilteredRow: View {
    @EnvironmentObject var dataModel: DataModel
    
    var dukeperson: DukePerson
    
    var body: some View {
        HStack {
            Image(uiImage: imageFromString(dukeperson.picture))
                .resizable()
                .frame(width: 120, height: 120)

            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(dukeperson.fName) \(dukeperson.lName), \(dukeperson.netId)")
                    .fontWeight(.bold)
                    .font(.system(size: 15))
                Text("\(dukeperson.description)")
                    .font(.system(size: 10))

            }
        }
    }
}

struct FilteredRow_Previews: PreviewProvider {
    static var previews: some View {
        FilteredRow(dukeperson: dataExample[0])
            .environmentObject(DataModel())
    }
}
