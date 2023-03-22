//
//  ClearableTextField.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/19/23.
//

import SwiftUI

struct ClearableTextField: View {
    @Binding var text: String
    var desc: String
    var body: some View {
        HStack {
            TextField(desc, text: $text)
                .autocapitalization(.none)
            
            Button(action: {
                self.text = ""
                
            }) {
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 12))
            }
            .padding(.trailing, 10)
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
    
}

struct ClearableTextField_Previews: PreviewProvider {
    @State static var searchTerm: String = "dd"
    static var previews: some View {
        ClearableTextField(text: $searchTerm, desc: "ab")
    }
}
