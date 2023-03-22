//
//  DataModel.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 1/22/23.
//

import UIKit
import AVFoundation

class DataModel: ObservableObject {
    @Published var database : [DukePerson] = []
    var audioPlayer: AVAudioPlayer?
    
    init() {
        loadFromDisk()
    }
    
    
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "chordark", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing music")
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    func loadReplace() {
        let url = URL(string: getUrl)!
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.setValue("Basic \(base64EncodedAuthString)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: httpRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)\n")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let dataFromServer = try JSONDecoder().decode([ServerDukePerson].self, from: data)
                var db = [DukePerson] ()
                for serverDukePerson in dataFromServer {
                    db.append(convertBtnDukePersonStructs(from: serverDukePerson))
                }
                DispatchQueue.main.async {
                    self.database = db
                    self.save()
                }
                
            } catch {
                print("Error decoding Json: \(error)\n")
            }
        }.resume()
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        DispatchQueue.main.async {
            do {
                let jsonData = try jsonEncoder.encode(self.database)
                try jsonData.write(to: sdURL)
            }
            catch {
                print("Failed to save database ")
            }
        }
    }
    
    
    func loadUpdate() {
        let url = URL(string: getUrl)!
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.setValue("Basic \(base64EncodedAuthString)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: httpRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)\n")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            
            do {
                let dataFromServer = try JSONDecoder().decode([ServerDukePerson].self, from: data)
                var db = [DukePerson] ()
                for serverDukePerson in dataFromServer {
                    db.append(convertBtnDukePersonStructs(from: serverDukePerson))
                }
                
                DispatchQueue.main.async {
                    for dukePerson in db {
                        if let indexDb =  self.database.firstIndex(where: { $0.netId == dukePerson.netId}) {
                            self.database[indexDb] = dukePerson
                        } else {
                            self.database.append(dukePerson)
                        }
                    }
                    self.save()
                }
            } catch {
                print("Error decoding Json: \(error)\n")
            }
        }.resume()
    }
    
    func loadFromDisk() {
        let jsonDecoder = JSONDecoder()
        DispatchQueue.main.async {
            do {
                print("sandbox success")
                let data = try Data(contentsOf: sdURL)
                let db = try jsonDecoder.decode([DukePerson].self, from: data)
                self.database = db
                self.save()
            }
            catch {
                print("Error loading database from Sandbox")
                let db = loadJsonFile()
                self.database = db
                self.save()
            }
        }
    }
    
    
    func search(fname: String? = nil, lname: String? = nil, from: String? = nil, hobby: String? = nil, movie: String? = nil, gender: Int? = nil, progLang: [String]? = nil, role: DukeRole? = nil, netId: String? = nil, team: String? = nil) -> [DukePerson]? {
        let filtered = database.filter { person in
            return (fname == nil || person.fName.lowercased().contains(fname!.lowercased())) &&
                   (lname == nil || person.lName.lowercased().contains(lname!.lowercased())) &&
                   (from == nil || person.from.lowercased().contains(from!.lowercased())) &&
                   (hobby == nil || person.hobby.lowercased().contains(hobby!.lowercased())) &&
                   (movie == nil || person.movie.lowercased().contains(movie!.lowercased())) &&
                   (gender == nil || person.gender == gender!) &&
                   (progLang == nil || progLang!.allSatisfy { person.progLang.contains($0) }) &&
                   (role == nil || person.role == role!) &&
                   (netId == nil || person.netId.lowercased().contains(netId!.lowercased())) &&
                   (team == nil || person.team.lowercased().contains(team!.lowercased()))
        }
        
        return filtered.isEmpty ? nil : filtered
    }
}








