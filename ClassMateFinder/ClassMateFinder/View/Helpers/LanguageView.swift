//
//  LanguageView.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/16/23.
//

import SwiftUI

struct LanguageView: View {
    var dukePerson: DukePerson
    var body: some View {
        VStack(alignment: .center) {
            
            if(dukePerson.progLang.count == 1) {
                LanguageBox(langName: dukePerson.progLang[0])
            }
            
            else if (dukePerson.progLang.count == 2) {
                
                HStack {
                    LanguageBox(langName: dukePerson.progLang[0])
                    Spacer()
                    LanguageBox(langName: dukePerson.progLang[1])
                }
                .padding(.horizontal, 70)
                
                
            }
            
            else if (dukePerson.progLang.count == 3) {
                
                HStack {
                    LanguageBox(langName: dukePerson.progLang[0])
                    Spacer()
                    LanguageBox(langName: dukePerson.progLang[1])
                    Spacer()
                    LanguageBox(langName: dukePerson.progLang[2])
                }
                .padding(.horizontal, 25)
                
            }
            
            else {
                LanguageBox(langName: "Unknown")
            }
            
        }
        .frame(width: 400)
        
        
    
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(dukePerson: dataExample[8]
        )
    }
}
