//
//  SearchViewControllerWrapper.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/26/23.
//

import SwiftUI


struct SearchViewControllerWrapper: UIViewControllerRepresentable {
    
    var dataModel: DataModel
    var toFilteredList:(([DukePerson], Bool) -> Void)?
    
    func makeCoordinator() -> SearchViewCoordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SearchViewControllerWrapper>) -> SearchViewController {
        let searchVC = SearchViewController()
        searchVC.dataModel = dataModel
        searchVC.delegate = context.coordinator
        return searchVC
    }
        
    func updateUIViewController(_ uiViewController: SearchViewController, context: UIViewControllerRepresentableContext<SearchViewControllerWrapper>) {

    }
}
