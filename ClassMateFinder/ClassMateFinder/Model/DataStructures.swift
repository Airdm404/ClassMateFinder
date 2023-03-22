//
//  DataStructures.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 1/22/23.
//

import UIKit

enum DukeRole: String, Codable, CaseIterable, Hashable {
    case Professor = "Professor"
    case TA = "TA"
    case Student = "Student"
    case Other = "Other"
}



struct DukePerson: CustomStringConvertible, Codable {
    var fName: String = "Unknown"
    var lName: String = "Unknown"
    var from: String = "Unknown"
    var hobby: String = "Unknown"
    var movie: String = "Unknown"
    var gender: Int = 0
    var progLang: [String] = ["Unknown"]
    var role: DukeRole = DukeRole.Other
    var netId: String
    var picture: String = "Unknown"
    var team: String = "Unknown"
    var email: String {
        return netId + "@duke.edu"
    }
    
    init(fName: String = "Unknown", lName: String = "Unknown", from: String = "Unknown", hobby: String = "Unknown", movie: String = "Unknown", gender: Int = 0, progLang: [String] = ["Swift"], role: DukeRole = DukeRole.Other, netId: String, picture: String = "Unknown", team: String = "Unknown") {
        self.fName = fName
        self.lName = lName
        self.from = from
        self.hobby = hobby
        self.movie = movie
        self.gender = gender
        self.progLang = progLang.prefix(3).map{String($0)}
        self.role = role
        self.netId = netId
        self.picture = picture
        self.team = team
    }
    
    
    var description: String {
        let describe =  "\(fName) \(lName) is from \(from) and is a \(role). \(printGenderSub(gender)) best programming \(printProgLang(progLang)). \(printGenderSub(gender)) favorite hobby is \(hobby) and \(printGenderSub(gender).lowercased()) favorite movie is \(movie). You can reach \(printGenderObj(gender)) at \(netId)@duke.edu."
        
        return describe
    }
}



struct ServerDukePerson: Codable {
    
    var firstname: String
    var lastname: String
    var wherefrom: String
    var gender: Int
    var role: String
    var languages: [String]
    var hobby: String
    var movie: String
    var picture: String
    var team: String
    var netid: String
    var email: String
    
    init(firstname: String = "", lastname: String = "", wherefrom: String = "", gender: Int = 0, role: String = "", languages: [String] = [], hobby: String = "", movie: String = "", picture: String = "", team: String = "", netid: String = "", email: String = "") {
        
        self.firstname = firstname
        self.lastname = lastname
        self.wherefrom = wherefrom
        self.gender = gender
        self.role = role
        self.languages = languages
        self.hobby = hobby
        self.movie = movie
        self.picture = picture
        self.team = team
        self.netid = netid
        self.email = email
    }
}






