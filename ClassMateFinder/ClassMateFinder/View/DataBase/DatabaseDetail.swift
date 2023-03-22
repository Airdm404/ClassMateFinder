//
//  DatabaseDetail.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct DatabaseDetail: View {

    @EnvironmentObject var dataModel: DataModel
    var dukePerson: DukePerson
    @State var isDbEditorShown: Bool = false
    @State private var showGraphicalView: Bool = false
    @State private var angle: Double = 0
        
    private var dbIndex: Int {
        dataModel.database.firstIndex(where: {
            $0.netId == dukePerson.netId
        }) ?? 0
    }

    var body: some View {
        ZStack{
            VStack {
                Spacer()
                ImageViewTop(dukePerson: dukePerson)
                    .offset(y:90)
                Spacer()
                ImageViewBottom(dukePerson: dukePerson, dbIndex: dbIndex)
                    .offset(y:50)
            }
            .blur(radius: showGraphicalView ? 10 : 0)
            .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
            

            if showGraphicalView {
                GraphicalView(showGraphicalView: $showGraphicalView, angle: $angle)
                    .onAppear {
                        dataModel.playMusic()
                    }
                    .onDisappear {
                        dataModel.stopMusic()
                    }
            }
        }
        .onTapGesture {
            withAnimation(.linear(duration: 0.6)) {
                angle += 180
                showGraphicalView.toggle()
            }
        }
        
        .navigationTitle("\(dukePerson.role.rawValue), \(dukePerson.netId)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: showGraphicalView ? AnyView(EmptyView()) : AnyView(Button {
            isDbEditorShown = true
            
        } label: {
            Text("Edit")
        }
        .sheet(isPresented: $isDbEditorShown) {
            DataBaseEditor(isDbEditorShown: $isDbEditorShown,
                           fname: dukePerson.fName,
                           lname: dukePerson.lName,
                           from: dukePerson.from,
                           hobby: dukePerson.hobby,
                           movie: dukePerson.movie,
                           gender: getGenderStringFromNumber(gender: dukePerson.gender),
                           role: dukePerson.role.rawValue,
                           progLang: dukePerson.progLang.joined(separator: ","),
                           netid: dukePerson.netId,
                           team: dukePerson.team,
                           dbIndex: dbIndex)
                .environmentObject(dataModel)
        }
        ))
        .navigationBarHidden(showGraphicalView)
    }
}

struct DatabaseDetail_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseDetail(dukePerson: dataExample[0])
            .environmentObject(DataModel())
    }
}
