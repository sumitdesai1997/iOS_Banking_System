//
//  SearchBusViewController.swift
//  iosBank
//
//  Created by Sumit Desai on 12/25/1399 AP.
//

import UIKit

class SearchBusViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromPickerView{
            fromTF.text = cityList[row]
            fromTF.resignFirstResponder()
        } else {
            toTF.text = cityList[row]
            toTF.resignFirstResponder()
        }
       
    }
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var fromPickerView = UIPickerView()
    var toPickerView = UIPickerView()
    
    var cityList = ["Toronto", "Mississauga", "Brampton", "Oshawa", "Hamilton", "Kitchner"]
    var priceList = [
    "TM1" : "9",
    "TB1" : "14",
    "TO1" : "19",
    "TH1" : "22",
    "TK1" : "35",
    "MT1" : "9",
    "MB1" : "7",
    "MO1" : "26",
    "MH1" : "15",
    "MK1" : "29",
    "BT1" : "14",
    "BM1" : "7",
    "BO1" : "29",
    "BH1" : "22",
    "BK1" : "28",
    "OT1" : "19",
    "OM1" : "26",
    "OB1" : "29",
    "OH1" : "41",
    "OK1" : "50",
    "HT1" : "22",
    "HM1" : "15",
    "HB1" : "22",
    "HO1" : "41",
    "HK1" : "21",
    "KT1" : "35",
    "KM1" : "29",
    "KB1" : "28",
    "KO1" : "50",
    "KH1" : "21"]
    
    var userList = [User]()
    var alertTitle = "Alert"
    var alertMessage = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fromPickerView.dataSource = self
        fromPickerView.delegate = self
        
        toPickerView.dataSource = self
        toPickerView.delegate = self
        
        fromTF.inputView = fromPickerView
        toTF.inputView = toPickerView
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        
        userName.text = "Sumit"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let srvc = segue.destination as! ShowingResultsViewController
        let from = fromTF.text!
        let to = toTF.text!
        srvc.from = from
        srvc.to = to
        
        for (key, value) in priceList{
            let from0 = Array(from)[0]
            let to0 = Array(to)[0]
            let key0 = Array(key)[0]
            let key1 = Array(key)[1]
                if (from0 == key0 && to0 == key1){
                    srvc.price = Double(value)!
                }
                   
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let from = fromTF.text, let to = toTF.text {
            if from == "" || to == "" {
                alertMessage = "Please enter value for all fields."
                return false
            } else {
                if !from.validName() || !to.validName(){
                    alertMessage = "Please enter valid city name"
                    return false
                }
                return true
            }
        }
        return false
    }
    
    @IBAction func clickSearchBus(_ sender: Any) {
        if shouldPerformSegue(withIdentifier: "SeachBusToShowingResults", sender: self){
            performSegue(withIdentifier: "SeachBusToShowingResults", sender: self)
        } else {
            openAlert(title: alertTitle, message: alertMessage, alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
        }
        
    }
}
