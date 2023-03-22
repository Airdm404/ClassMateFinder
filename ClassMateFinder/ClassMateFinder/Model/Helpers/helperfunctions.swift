//
//  helperfunctions.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 1/24/23.
//

import UIKit
import SwiftUI


func printProgLang(_ progLang: [String]) -> String {
    if (progLang.count == 0) {
        return ("language is unknown")
    }
    
    if (progLang.count == 1) {
        return ("language is \(progLang[0])")
    }
    else if (progLang.count == 2) {
        return ("languages are \(progLang[0]) and \(progLang[1])")
    }
    
    return ("languages are \(progLang[0]), \(progLang[1]) and \(progLang[2])")
}


func printGenderSub(_ personGender: Int) -> String {
    if (personGender == 1) {
        return "His"
    }
    else if (personGender == 2) {
        return "Her"
    }
    
    return "Their"
}


func printGenderObj(_ personGender: Int) -> String {
    if (personGender == 1) {
        return "him"
    }
    else if (personGender == 2) {
        return "her"
    }
    
    return "them"
}

//function from persistent storage playground
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

func getDukeRole(role : String) -> DukeRole {
    let roletype = DukeRole(rawValue: role)
    return roletype!
}

func getGenderNumberFromString(gender : String) -> Int {
    if (gender == "Unknown") {
        return 0
    }
    if (gender == "Male") {
        return 1
    }
    if (gender == "Female") {
        return 2
    }
    
    return 3
}

func getGenderStringFromNumber(gender: Int) -> String {
    if (gender == 0) {
        return "Unknown"
    }
    if (gender == 1) {
        return "Male"
    }
    if (gender == 2) {
        return "Female"
    }
    
    return "Other"
}


func loadJsonFile() -> [DukePerson] {
    var db: [DukePerson] = []
    let eceJson = Bundle.main.url(forResource: "ECE564Cohort", withExtension: "json")!
    let jsonData = try! Data(contentsOf: eceJson)
    let json = try! JSONDecoder().decode([ServerDukePerson].self, from: jsonData)
    for data in json {
        db.append(convertBtnDukePersonStructs(from: data))
    }
    return db
}


func convertBtnDukePersonStructs(from dukePerson: DukePerson) -> ServerDukePerson {
    return ServerDukePerson(firstname: dukePerson.fName,
                            lastname: dukePerson.lName,
                            wherefrom: dukePerson.from,
                            gender: dukePerson.gender,
                            role: dukePerson.role.rawValue,
                            languages: dukePerson.progLang,
                            hobby: dukePerson.hobby,
                            movie: dukePerson.movie,
                            picture: dukePerson.picture,
                            team: dukePerson.team,
                            netid: dukePerson.netId,
                            email: dukePerson.email)
    
}


func convertBtnDukePersonStructs(from serverDukePerson: ServerDukePerson) -> DukePerson {
    let role: DukeRole
    switch serverDukePerson.role {
    case "Professor":
        role = .Professor
    case "TA":
        role = .TA
    case "Student":
        role = .Student
    default:
        role = .Other
    }
    
    return DukePerson(fName: serverDukePerson.firstname,
                      lName: serverDukePerson.lastname,
                      from: serverDukePerson.wherefrom,
                      hobby: serverDukePerson.hobby,
                      movie: serverDukePerson.movie,
                      gender: serverDukePerson.gender,
                      progLang: serverDukePerson.languages,
                      role: role,
                      netId: serverDukePerson.netid,
                      picture: serverDukePerson.picture,
                      team: serverDukePerson.team)
}




func stringFromImage(_ imagePic: UIImage) -> String {
    let picImageData: Data = imagePic.jpegData(compressionQuality: 1.0)!
    let picBase64 = picImageData.base64EncodedString()
    return picBase64
}

func imageFromString(_ strPic: String) -> UIImage {
    var picImage: UIImage?
    if (String(strPic.prefix(4)) == "/9j/") {
        let picImageData = Data(base64Encoded: strPic, options: .ignoreUnknownCharacters)
        picImage = UIImage(data: picImageData!)
    } else {
        picImage = avatar
    }
    return picImage!
}


func base64pic(_ imageName: String) -> String? {
    var base64String: String?
    if let picImage = UIImage(named: imageName) {
        base64String = stringFromImage(picImage)
    }
    return base64String
}


func langUserToDbInput(_ langInput: String) -> [String] {
    let lang = langInput.split(separator: ",")
    return lang.map(String.init)
}


func encodeDukePersonToJSONData(person : DukePerson) -> Data? {
    let serverDukePerson = convertBtnDukePersonStructs(from: person)
    let encoder = JSONEncoder()
    let data: Data
    
    do {
        data = try encoder.encode(serverDukePerson)
        return data
    } catch {
        print("Error encoding")
        return nil
    }
}



func uploadDataToServer(dukePerson: DukePerson, completion: @escaping (Result<Void, Error>) -> Void) {
    let url = URL(string: putUrl)!
    var httpRequest = URLRequest(url: url)
    httpRequest.httpMethod = "PUT"
    httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    httpRequest.setValue("Basic \(base64EncodedAuthString)", forHTTPHeaderField: "Authorization")
    httpRequest.httpBody = encodeDukePersonToJSONData(person: dukePerson)
    URLSession.shared.dataTask(with: httpRequest) { data, response, error in
        if let error = error {
            print("Error: \(error)\n")
            completion(.failure(error))
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            let statusCode = httpResponse.statusCode
            print("HTTP Error: \(statusCode)\n")
            completion(.failure(NSError(domain: "HTTPError", code: statusCode, userInfo: nil)))
            return
        }
        
        DispatchQueue.main.async {
            completion(.success(()))
        }
    }.resume()
    
}
