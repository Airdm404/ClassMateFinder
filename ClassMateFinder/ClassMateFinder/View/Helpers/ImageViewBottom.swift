//
//  CardView.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct ImageViewBottom: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var dataModel: DataModel
    var dukePerson: DukePerson
    @State var isAlertPresented: Bool = false
    var dbIndex: Int
    
    var body: some View {
        ZStack(alignment: Alignment.leading) {
            Rectangle()
                .fill(Color.white)
                .frame(height: 450)
                .cornerRadius(35)

            VStack(alignment: .leading) {
                HStack {
                    MovieIcon(dukePerson: dukePerson)
                    Spacer()
                    HobbyIcon(dukePerson: dukePerson)
                }
                .padding(.top, 155)
                .padding(.horizontal, 40)
                .padding(.bottom, 7)
                
                Divider()
                    .padding(.bottom, -10)
    
                Text("Languages")
                    .bold()
                    .font(.headline)
                    .padding(.horizontal, 40)
                    .padding(.top, 2)
                    .padding(.bottom, -1)
                
                LanguageView(dukePerson: dukePerson)

                Divider()
                    .padding(.top, 4)
                
                Text("Description")
                    .bold()
                    .font(.headline)
                    .padding(.horizontal, 40)
                    .padding(.bottom, -3)
                    .padding(.top, 0)
                
                Text(dukePerson.description)
                    .padding(.horizontal, 40)
                    .font(.custom("Helvetica", size: 13))
                    .padding(.bottom, 5)
                
                Divider()
                    .padding(.bottom, -1)
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color(hue: 0.621, saturation: 1.0, brightness: 1.0, opacity: 0.178))
                    Text(dukePerson.email)
                        .font(.footnote)
                    
                    Spacer()
                    
                    Button(action: {
                        isAlertPresented = true
                        
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color.red)
                            .font(.system(size: 13))
                        
                    }
                    .alert("Are you sure?", isPresented: $isAlertPresented) {
                        Button("Yes") {
                            isAlertPresented = false
                            presentationMode.wrappedValue.dismiss()
                            dataModel.database.remove(at: dbIndex)
                            dataModel.save()
                        }
                        Button("No") {
                            isAlertPresented = false
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
            .padding(.top, -300)
        }
        .background(Color.white)
        .cornerRadius(35)
        .shadow(radius: 5)
        .frame(width: 400, height: 450)
        
    }
}


struct ImageViewBottom_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewBottom(dukePerson: dataExample[0], dbIndex: 0)
            .environmentObject(DataModel())
    }
}
