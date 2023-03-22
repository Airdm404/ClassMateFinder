//
//  ContentView.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 1/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .list
    
    enum Tab {
        case list
        case filtered
    }
    
    
    var body: some View {
        TabView(selection: $selection) {
            DatabaseList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
            FilteredList()
                .tabItem {
                    Label("Filtered", systemImage: "slider.vertical.3")
                }
                .tag(Tab.filtered)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
