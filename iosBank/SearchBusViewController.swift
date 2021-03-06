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
    var user = User()
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
        
        userName.text = "Hi \(user.name)"
        
        fillData()
        
        print("Search bus in: \(user.balance)")
    }
    
    func fillData(){
        busList.append(Bus(busName: "McCoy Express", isExpress: true, isSleeper: false,
        hasAC: false, hasWifi: false, images: ["mc1","mc2","mc3"],
         description: "One of the top buses in Toronto.The bus provides smooth journey in enitre Ontario.", from: ["Toronto","Mississauga","Brampton"], to: ["Surat"], review: 9.0, multiplier: 1.05, price: 0.0))
        busList.append(Bus(busName: "Ontario Northland Express", isExpress: false,isSleeper: false,
        hasAC: false, hasWifi: true,images: ["on1","on2","on3"],
        description: "This bus operator provides buses with moderns service. This bus provides only express service along with Wifi, Netflix, Food and Live tracking.", from: ["Mississauga","Brampton","Hamilton"], to: ["KIM"], review: 7.9, multiplier: 0.98, price: 0.0))
        busList.append(Bus(busName: "Great Canadain Travels", isExpress: false,isSleeper: false,
        hasAC: false, hasWifi: false, images: ["gc1","gc2","gc3"],
         description: "One of the oldest bus operator from the Canada. This bus will ease your travel from and to Ontario destination.", from: ["Mississauga","Brampton","Oshawa"], to: ["Bharuch"], review: 7.0, multiplier: 0.95, price: 0.0))
        busList.append(Bus(busName: "Franklin Travels", isExpress: true, isSleeper: true,
        hasAC: true, hasWifi: false, images: ["f1","f2","f3"],
        description: "One of the High rated bus operator buses in Canada. This  Express Bus provides facilities like AC, Netflix, Wifi and many more.", from: ["Toronto","Oshawa","Hamilton"], to: ["Khambhat"], review: 9.6, multiplier: 1.25, price: 0.0))
        busList.append(Bus(busName: "Coach Canada Travels", isExpress: true,isSleeper: true,
        hasAC: true, hasWifi: true,images: ["cc1","cc2","cc3"],
         description: "This bus operator is highly recommend for good services. This Express bus provide all the service that need during the travel from Wifi and AC to Netflix and Food.",
        from: ["Mississauga","Kitchner","Toronto"], to: ["Valsad"], review: 9.2, multiplier: 1.20, price: 0.0))
        busList.append(Bus(busName: "Pacific Western Travels", isExpress: true, isSleeper: false,
        hasAC: true,hasWifi: true,images: ["pw1","pw2","pw3"],
         description: "One of the highly reputed bus operator in Toronto since last 10 years. This bus provides many optional services from which user can select the service they need.", from: ["Kitchner","Oshawa"], to: ["Bharuch"], review: 8.0, multiplier: 0.90, price: 0.0))
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
        user.balance = user.balance - totalPayment
        wvc?.user = user
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
    
    @IBAction func clickSignOut(_ sender: Any) {
        let sbvc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(sbvc, animated: true)
    }
    
}
