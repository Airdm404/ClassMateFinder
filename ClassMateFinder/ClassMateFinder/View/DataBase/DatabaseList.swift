//
//  DatabaseList.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/15/23.
//

import SwiftUI

struct DatabaseList: View {
    @EnvironmentObject var dataModel: DataModel
    @State private var searchTerm: String = ""
    
    @State private var showSheet = false
    @State var isAlertPresented: Bool = false
    @State var isDbEditorShown: Bool = false
    @State private var showActionSheet = false
    
    @State var dbIndexToEdit: Int = -1
    @State var dbFnameToEdit: String = ""
    @State var dbLnameToEdit: String = ""
    @State var dbFromToEdit: String = ""
    @State var dbHobbyToEdit: String = ""
    @State var dbMovieToEdit: String = ""
    @State var dbGenderToEdit: String = ""
    @State var dbRoleToEdit: String = ""
    @State var dbProgLangToEdit: String = ""
    @State var dbNetIdToEdit: String = ""
    @State var dbTeamToEdit: String = ""

    
    private var bindingIsDbEditorShown: Binding<Bool> { Binding (
        get: { dbNetIdToEdit != "" && dbIndexToEdit != -1 },
        set: { _ in
                dbNetIdToEdit = ""
                dbIndexToEdit = -1
                dbFnameToEdit = ""
                dbLnameToEdit = ""
                dbFromToEdit = ""
                dbHobbyToEdit = ""
                dbMovieToEdit = ""
                dbGenderToEdit = ""
                dbRoleToEdit = ""
                dbProgLangToEdit = ""
                dbTeamToEdit = ""
            }
        )
    }
    

    var filteredDatabase: [String: [DukePerson]] {
        let initialResult: [String: [DukePerson]] = [
            "Professor": [],
            "TA": [],
            "Gather Green": [],
            "Spodts": [],
            "Course Builder": [],
            "Engen": [],
            "Coffee Seekers": [],
            "Sharing Ledger": [],
            "Student": []
        ]
        
        let teams = ["gather green", "spodts", "course builder", "engen", "coffee seekers", "sharing ledger"]
        
        let intermediateResult = searchTerm.isEmpty ? dataModel.database.reduce(into: initialResult) { result, dukePerson in
            switch dukePerson.role {
            case .Professor:
                result["Professor", default: []].append(dukePerson)
            case .TA:
                result["TA", default: []].append(dukePerson)
            case .Student:
                   let team = dukePerson.team.lowercased()
                   if teams.contains(team) {
                    result[team.capitalized, default: []].append(dukePerson)
                } else {
                    result["Student", default: []].append(dukePerson)
                }
            default:
                result["Other", default: []].append(dukePerson)
            }
        } : dataModel.database.filter {
            $0.description.localizedCaseInsensitiveContains(self.searchTerm)
        }.reduce(into: initialResult) { result, dukePerson in
            switch dukePerson.role {
            case .Professor:
                result["Professor", default: []].append(dukePerson)
            case .TA:
                result["TA", default: []].append(dukePerson)
            case .Student:
                   let team = dukePerson.team.lowercased()
                   if teams.contains(team) {
                    result[team.capitalized, default: []].append(dukePerson)
                } else {
                    result["Student", default: []].append(dukePerson)
                }
            default:
                result["Other", default: []].append(dukePerson)
            }
        }
        
        return intermediateResult.filter  { !$0.value.isEmpty }
    }
    
    let orderOfKeys = ["Professor", "TA", "Student", "Coffee Seekers", "Course Builder", "Engen", "Gather Green", "Sharing Ledger", "Spodts", "Other"]


     
    
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $searchTerm)
                if (filteredDatabase.isEmpty) {
                    Text("No Results Found")
                }
                else {
                    ForEach(filteredDatabase.keys.sorted { orderOfKeys.firstIndex(of: $0) ?? Int.max < orderOfKeys.firstIndex(of: $1) ?? Int.max }, id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(filteredDatabase[key]!, id: \.netId) { dukePerson in
                                NavigationLink {
                                    DatabaseDetail(dukePerson: dukePerson)
                                        .environmentObject(dataModel)
                                    
                                } label: {
                                    DatabaseRow(dukeperson: dukePerson)
                                        .environmentObject(dataModel)
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                      Button {
                                          dbIndexToEdit = dataModel.database.firstIndex(where: { $0.netId == dukePerson.netId})!
                                          dbFnameToEdit = dukePerson.fName
                                          dbLnameToEdit = dukePerson.lName
                                          dbFromToEdit = dukePerson.from
                                          dbHobbyToEdit = dukePerson.hobby
                                          dbMovieToEdit = dukePerson.movie
                                          dbGenderToEdit = getGenderStringFromNumber(gender: dukePerson.gender)
                                          dbRoleToEdit = dukePerson.role.rawValue
                                          dbProgLangToEdit = dukePerson.progLang.joined(separator: ",")
                                          dbNetIdToEdit = dukePerson.netId
                                          dbTeamToEdit = dukePerson.team
                    
                                      } label: {
                                        Text("Edit")
                                      }
                                      .tint(.blue)
                                    }
                                .sheet(isPresented: bindingIsDbEditorShown) {
                                    DataBaseEditor(isDbEditorShown: bindingIsDbEditorShown,
                                                   fname: dbFnameToEdit,
                                                   lname: dbLnameToEdit,
                                                   from: dbFromToEdit,
                                                   hobby: dbHobbyToEdit,
                                                   movie: dbMovieToEdit,
                                                   gender: dbGenderToEdit,
                                                   role: dbRoleToEdit,
                                                   progLang: dbProgLangToEdit,
                                                   netid: dbNetIdToEdit,
                                                   team: dbTeamToEdit,
                                                   dbIndex: dbIndexToEdit)
                                        .environmentObject(dataModel)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                      Button(role: .destructive) {
                                          isAlertPresented = true
                                          dataModel.database.removeAll(where: { $0.netId ==  dukePerson.netId})
                                          dataModel.save()
                                          
                                      } label: {
                                       Label("Delete", systemImage: "trash")
                                      }
                                      .tint(.red)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Database")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label : {
                        Label("Add Person", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showActionSheet.toggle()
                    } label : {
                        Label("Change DB Source", systemImage: "arrow.clockwise")
                    }
                }

            }
            .sheet(isPresented: $showSheet) {
                DataBaseEditor(isDbEditorShown: $showSheet)
                    .environmentObject(dataModel)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Refresh Database"), message: Text("What would you like to do?"), buttons: [
                    .default(Text("Replace")) {
                        dataModel.loadReplace()
                    },
                    .default(Text("Update")) {
                        dataModel.loadUpdate()
                    },
                    .default(Text("Load from Disk")) {
                        dataModel.loadFromDisk()
                    },
                    .cancel()
                ])
            }
        }
    }
}

struct DatabaseList_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseList()
            .environmentObject(DataModel())
    }
}
