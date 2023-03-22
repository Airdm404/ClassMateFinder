//
//  FilteredDetail.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/28/23.
//

import SwiftUI

struct FilteredDetail: View {
    @EnvironmentObject var dataModel: DataModel
    var dukePerson: DukePerson
    
    var body: some View {
        VStack {
            Spacer()
            ImageViewTop(dukePerson: dukePerson)
                .offset(y:90)
            Spacer()
            FilteredBottomImageView(dukePerson: dukePerson)
                .offset(y:50)
        }
        .navigationTitle("\(dukePerson.role.rawValue), \(dukePerson.netId)")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct FilteredDetail_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetail(dukePerson: dataExample[0])
            .environmentObject(DataModel())
    }
}
