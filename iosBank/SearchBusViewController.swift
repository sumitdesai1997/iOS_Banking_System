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
    @IBOutlet weak var dateTF: UITextField!
    
    var fromPickerView = UIPickerView()
    var toPickerView = UIPickerView()
    var datePicker = UIDatePicker()
    
    var cityList = ["Surat", "Nadiad", "Khambhat", "Ahmedabad", "Toronto"]
    
    var userList = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fromPickerView.dataSource = self
        fromPickerView.delegate = self
        
        toPickerView.dataSource = self
        toPickerView.delegate = self
        
        
        fromTF.inputView = fromPickerView
        toTF.inputView = toPickerView
        
        customDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func customDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(clickDone))
        
        toolbar.setItems([doneButton], animated: true)
        
        dateTF.inputAccessoryView = toolbar
        dateTF.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func clickDone(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}
