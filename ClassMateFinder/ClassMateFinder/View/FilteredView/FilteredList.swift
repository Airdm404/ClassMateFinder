//
//  FilteredList.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/24/23.
//

import SwiftUI

struct FilteredList: View {
    @EnvironmentObject var dataModel: DataModel
    @State private var showSearchViewController: Bool = false
    @State var searchViewArray: [DukePerson] = []
    
    
    var dbToDisplay: [DukePerson] {
        searchViewArray.isEmpty ? dataModel.database : searchViewArray
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dbToDisplay, id: \.netId) { dukePerson in
                    NavigationLink {
                        FilteredDetail(dukePerson: dukePerson)
                    } label: {
                        FilteredRow(dukeperson: dukePerson)
                    }
                }
            }
            .navigationTitle("Filtered")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter") {
                        showSearchViewController.toggle()
                    }
                    .sheet(isPresented: $showSearchViewController) {
                        SearchViewControllerWrapper(dataModel: dataModel, toFilteredList: { searchArr, dismissSearchView in
                            self.showSearchViewController = dismissSearchView
                            self.searchViewArray = searchArr
                        })
                    }
                }
            }
            .navigationBarItems(leading:
                Button(action: {
                    searchViewArray = []
                }) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            )
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList()
            .environmentObject(DataModel())
    }
}



