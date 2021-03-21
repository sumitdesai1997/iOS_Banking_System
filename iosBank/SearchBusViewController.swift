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
            if(toTF.text == cityList[row]){
                openAlert(title: "Alert", message: "Value for the From city and To city can not be the same", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                return
            }
            fromTF.text = cityList[row]
            fromTF.resignFirstResponder()
        } else {
            if(fromTF.text == cityList[row]){
                openAlert(title: "Alert", message: "Value for the From city and To city can not be the same", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                return
            }
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
    
    var busList = [Bus]()
    var user = User(name: "test", email: "test123@gmail.com", password: "12345678q", question: "buzzo", balance: 70.0)
    var price = 0.0
    var totalPayment = 0.0
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
        
        userName.text = String(user.balance)
        
        fillData()
        
        print("Search bus in: \(user.balance)")
    }
    
    func fillData(){
        busList.append(Bus(busName: "Sumit Dhanadhan Travells", isExpress: true, isSleeper: true, hasAC: true, hasWifi: true, images: ["sumit1","sumit2","sumit3"], description: "One of the top buses in IndiaOne of the top buses in IndiaOne of the top buses in IndiaOne of the top buses in India.", from: [], to: [], review: 10.0, multiplier: 1.25, price: 0.0))
        busList.append(Bus(busName: "Mihin Vana Wow Wow Travells", isExpress: true, isSleeper: false, hasAC: false, hasWifi: false, images: ["mihin1","mihin2","mihin3"], description: "One of the top buses in Gujarat", from: [], to: [], review: 9.0, multiplier: 00.90, price: 0.0))
        busList.append(Bus(busName: "Krishna Canada Travells", isExpress: false, isSleeper: false, hasAC: false, hasWifi: true, images: ["krishna1","krishna2","krishna3"], description: "One of the top buses in Canada", from: [], to: [], review: 9.2, multiplier: 1.10, price: 0.0))
        busList.append(Bus(busName: "Tulsi Express Travells", isExpress: true, isSleeper: true, hasAC: true, hasWifi: false, images: ["tulsi1","tulsi2","tulsi3"], description: "One of the top buses in Ahmedabad", from: [], to: [], review: 8.5, multiplier: 1.0, price: 0.0))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let srvc = segue.destination as? ShowingResultsViewController
        let from = fromTF.text!
        let to = toTF.text!
        
        srvc?.from = from
        srvc?.to = to
        srvc?.travelDate = datePicker.date
        srvc?.user = user
        
        if(from != "" && to != ""){
            for (key, value) in priceList{
                let from0 = Array(from)[0]
                let to0 = Array(to)[0]
                let key0 = Array(key)[0]
                let key1 = Array(key)[1]
                    if (from0 == key0 && to0 == key1){
                        price = Double(value)!
                    }
            }
           
            for bus in busList{
                bus.price = price * bus.multiplier
                bus.price = Double(String(format: "%.2f", bus.price))!
            }
        }
        
        srvc?.busList = busList
        
        let wvc = segue.destination as? WalletViewController
        wvc?.user.balance = user.balance - totalPayment
        wvc?.isFromSearchBus = true
    }
    
    @IBAction func clickYourWallet(_ sender: Any) {
        performSegue(withIdentifier: "YourWalletToWallet", sender: self)
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
