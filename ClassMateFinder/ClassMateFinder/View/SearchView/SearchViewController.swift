//
//  SearchViewController.swift
//  ClassMateFinder
//
//  Created by Edem Ahorlu on 1/28/23.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ controller: SearchViewController, didSelectSearchResults results: [DukePerson])
}



class SearchViewController: UIViewController {
    
    var dataModel: DataModel?
    var searchArray: [DukePerson] = []

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var netidTF: UITextField!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var hobbyTF: UITextField!
    @IBOutlet weak var movieTF: UITextField!
    @IBOutlet weak var langTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var roleTF: UITextField!
    @IBOutlet weak var teamTF: UITextField!
    
    let genders = ["Unknown", "Male", "Female", "Other"]
    let roles = ["Professor", "TA", "Student", "Other"]
    
    var genderPickerView = UIPickerView()
    var rolePickerView = UIPickerView()
    
    weak var delegate: SearchViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        genderTF.inputView = genderPickerView
        roleTF.inputView = rolePickerView
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        rolePickerView.delegate = self
        rolePickerView.dataSource = self
        
        genderPickerView.tag = 1
        rolePickerView.tag = 2
        
        textViewProperties()

    }
    
    func textViewProperties() {
        textView.isScrollEnabled =  true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
    }
    
    func clearFields() {
        fnameTF.text = ""
        lnameTF.text = ""
        netidTF.text = ""
        fromTF.text = ""
        hobbyTF.text = ""
        movieTF.text = ""
        langTF.text = ""
        genderTF.text = ""
        roleTF.text = ""
        teamTF.text = ""
    }
    
    
    @IBAction func SearchButton(_ sender: UIButton) {
        let fnameInput: String? = fnameTF.text!.isEmpty ? nil : fnameTF.text
        let lnameInput: String? = lnameTF.text!.isEmpty ? nil : lnameTF.text
        let netIdInput: String? = netidTF.text!.isEmpty ? nil : netidTF.text
        let fromInput: String? = fromTF.text!.isEmpty ? nil : fromTF.text
        let hobbyInput: String? = hobbyTF.text!.isEmpty ? nil : hobbyTF.text
        let movieInput: String? = movieTF.text!.isEmpty ? nil : movieTF.text
        let langInput: [String]? = langTF.text?.isEmpty == false ? langTF.text?.components(separatedBy: ",") : nil
        let genderInput: Int? = genderTF.text?.isEmpty == false ? getGenderNumberFromString(gender: genderTF.text!) : nil
        let roleInput: DukeRole? = roleTF.text?.isEmpty == false ? DukeRole(rawValue: roleTF.text!) : nil
        let teamInput: String? = teamTF.text!.isEmpty ? nil : teamTF.text
        
        if let results = dataModel?.search(
        fname: fnameInput,
        lname: lnameInput,
        from: fromInput,
        hobby: hobbyInput,
        movie: movieInput,
        gender: genderInput,
        progLang: langInput,
        role: roleInput,
        netId: netIdInput,
        team: teamInput
        ) {
            searchArray = results
            textView.text = "\(results.count) People Found\n"
        } else {
            textView.text = "No Results Found"
        }
    }
    
    @IBAction func ListButton(_ sender: UIButton) {
        textView.text = ""
        for person in searchArray {
            textView.text += "\(person.fName) \(person.lName), \(person.netId)\n"
        }
    }
    
    @IBAction func ClearButton(_ sender: UIButton) {
        clearFields()
    }
    
    @IBAction func ReturnButton(_ sender: UIButton) {
        self.delegate?.searchViewController(self, didSelectSearchResults: searchArray)
    }
    
}


extension SearchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return genders.count
        case 2:
            return roles.count
        default:
            return 1
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return genders[row]
        case 2:
            return roles[row]
        default:
            return "Data Not Found"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            genderTF.text = genders[row]
            genderTF.resignFirstResponder()
            
        case 2:
            roleTF.text = roles[row]
            roleTF.resignFirstResponder()
        default:
            return
        }
    }
    
}


