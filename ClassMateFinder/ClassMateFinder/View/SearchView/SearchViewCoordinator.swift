//
//  SearchViewCoordinator.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/28/23.
//

import SwiftUI

final class SearchViewCoordinator: NSObject, SearchViewControllerDelegate {
    
    var parent: SearchViewControllerWrapper

    init(_ parent: SearchViewControllerWrapper) {
        self.parent = parent
    }
    
    func searchViewController(_ controller: SearchViewController, didSelectSearchResults results: [DukePerson]) {
        let dismissSearchView = false
        self.parent.toFilteredList?(results, dismissSearchView)
    }
}
