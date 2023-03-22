//
//  DatabaseEditor.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 2/19/23.
//

import SwiftUI

struct DataBaseEditor: View {
    @Binding var isDbEditorShown: Bool
    @State var isAlertPresented: Bool = false
    @State var fname: String = ""
    @State var lname: String = ""
    @State var from: String = ""
    @State var hobby: String = ""
    @State var movie: String = ""
    @State var gender: String = "Unknown"
    @State var role: String = "Other"
    @State var progLang: String = ""
    @State var netid: String = ""
    @State var team: String = ""
    let genderSelect = ["Unknown", "Male", "Female", "Other"]
    let roleSelect = ["Professor", "TA", "Student", "Other"]
    @EnvironmentObject var dataModel: DataModel
    var dbIndex = -1

    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("NetID")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $netid, desc: "netid")
                }
                
                HStack {
                    Text("First Name")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $fname, desc: "e.g. John")
                }
                
                HStack {
                    Text("Last Name")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $lname, desc: "e.g. Smith")
                }
                
                HStack {
                    Text("From")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $from, desc: "hometown")
                }
                
                HStack {
                    Text("Hobby")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $hobby, desc: "favorite hobby")
                }
                
                HStack {
                    Text("Movie")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $movie, desc: "favorite movie")
                }
                
                HStack {
                    Text("Team")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $team, desc: "e.g. Gather Green")
                }
                
                HStack {
                    Text("Programming Languages")
                        .bold()
                        .frame(width: 110)
                    Divider()
                    ClearableTextField(text: $progLang, desc: "separate by \",\" (3)")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Gender")
                        .bold()
                    Picker("GenderSelect", selection: $gender) {
                        ForEach(genderSelect, id: \.self) { gend in
                            Text(gend)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Role")
                        .bold()
                    Picker("RoleSelect", selection: $role) {
                        ForEach(roleSelect, id: \.self) { role in
                            Text(role)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            
            }
            .navigationTitle(dbIndex == -1 ? "New Person" : "Edit Person")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button {
                isDbEditorShown = false
            } label: {
                Label("Cancel", systemImage: "chevron.left")
                    .labelStyle(.titleOnly)
            })
            .navigationBarItems(trailing: Button {
                guard netid.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
                    isAlertPresented = true
                    return
                }
                if (dbIndex == -1) {
                    var person = DukePerson(netId: netid)
                    person.fName = fname
                    person.lName = lname
                    person.from = from
                    person.hobby = hobby
                    person.movie = movie
                    person.team = team
                    person.progLang = langUserToDbInput(progLang)
                    person.gender =  getGenderNumberFromString(gender: gender)
                    person.role = getDukeRole(role: role)
                    
                    dataModel.database.append(person)
            
                } else {
                    let person = DukePerson(fName: fname,
                                            lName: lname,
                                            from: from,
                                            hobby: hobby,
                                            movie: movie,
                                            gender: getGenderNumberFromString(gender: gender),
                                            progLang: langUserToDbInput(progLang),
                                            role: getDukeRole(role: role),
                                            netId: dataModel.database[dbIndex].netId,
                                            picture: dataModel.database[dbIndex].picture,
                                            team: team
                    )
                    
                    dataModel.database[dbIndex] = person
                    if(dataModel.database[dbIndex].netId == "eka13") {
                        uploadDataToServer(dukePerson:dataModel.database[dbIndex]) { result in
                            switch result {
                            case .success:
                                print("Data Uploaded")
                            case.failure:
                                print("Failed to Upload")
                            }
                       
                        }
                    }
                    print(dataModel.database[dbIndex].role.rawValue)
                }
                isDbEditorShown = false
            } label: {
                Label("Save", systemImage: "chevron.left")
                    .labelStyle(.titleOnly)
            }
                .alert("NetId is Required to Create New Person", isPresented: $isAlertPresented) {
                    Button("OK") {
                    isAlertPresented = false
                    }
                }
            )
        }
    }
}

struct DataBaseEditor_Previews: PreviewProvider {
    static var previews: some View {
        DataBaseEditor(isDbEditorShown: .constant(true))
            .environmentObject(DataModel())
    }
}
