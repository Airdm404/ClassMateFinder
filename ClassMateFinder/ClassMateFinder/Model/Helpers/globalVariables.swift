//
//  globalVariables.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 1/30/23.
//

import UIKit

let dbName = "database.json"
let sdURL = getDocumentsDirectory().appendingPathComponent(dbName)

let getUrl = "https://ece564sp23.colab.duke.edu/entries/all"
let putUrl = "https://ece564sp23.colab.duke.edu/entries/eka13"
let myNetID = "eka13"
let myPass = "e0798c5813cdb430c11a214dbe445b2b51fecb90370d0842e569c9810af3ff93"
let authString = "\(myNetID):\(myPass)"
let authStringData = authString.data(using: .utf8)
let base64EncodedAuthString = authStringData!.base64EncodedString()
let avatar = UIImage(named: "noProfile")


var dataExample = loadJsonFile()






