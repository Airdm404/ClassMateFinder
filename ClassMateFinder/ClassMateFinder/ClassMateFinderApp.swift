//
//  ClassMateFinderApp.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 1/22/23.
//

import SwiftUI

@main
struct ClassMateFinderApp: App {
    @StateObject private var dataModel = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dataModel)
        }
    }
}
