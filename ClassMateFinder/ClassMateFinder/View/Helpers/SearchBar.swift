//
//  SearchBar.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .autocapitalization(.none)
                .background(Color.white)
                .frame(width: 300, height: 30)
                .cornerRadius(20)
        }
        .padding(.horizontal)
        .frame(width: 300, height: 30)
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchTerm: String = ""
    static var previews: some View {
        SearchBar(text: $searchTerm)
    }
}
