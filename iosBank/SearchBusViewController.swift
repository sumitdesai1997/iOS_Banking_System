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
    
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var fromPickerView = UIPickerView()
    var toPickerView = UIPickerView()
    
    var cityList = ["Surat", "Nadiad", "Khambhat", "Ahmedabad", "Toronto"]
    
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let srvc = segue.destination as! ShowingResultsViewController
        srvc.from = fromTF.text!
        srvc.to = toTF.text!
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
