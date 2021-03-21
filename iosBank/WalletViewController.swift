//
//  WalletViewController.swift
//  iosBank
//
//  Created by Sumit Desai on 12/30/1399 AP.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var ccTitle: UILabel!
    @IBOutlet weak var ccNumber: UILabel!
    @IBOutlet weak var ccNumberTF: UITextField!
    @IBOutlet weak var ccName: UILabel!
    @IBOutlet weak var ccNameTF: UITextField!
    @IBOutlet weak var ccExpiry: UILabel!
    @IBOutlet weak var ccExpiryTF: UITextField!
    @IBOutlet weak var ccCVV: UILabel!
    @IBOutlet weak var ccCVVTF: UITextField!
    @IBOutlet weak var ccAmount: UILabel!
    @IBOutlet weak var ccAmountTF: UITextField!
    @IBOutlet weak var ccAddToWallet: UIButton!
    @IBOutlet weak var homePage: UIButton!
    @IBOutlet weak var bookingPage: UIButton!
    
    var userBalance = 0.0
    var isFromBusDetail = false
    var isFromSearchBus = false
    
    var name = ""
    var images = [String]()
    var information = ""
    var from = ""
    var to = ""
    var price = 0.0
    var tempPrice = 0.0
    var extraService = 0.0
    var numberSeatPrice = 0.0
    var totalPrice = 0.0
    var isFood = false
    var isLiveTracking = false
    var isNetflix = false
    var isElectricPlug = false
    var isAc = false
    var isSleeper = false
    var numberOfSeats = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ccTitle.isHidden = true
        ccNumber.isHidden = true
        ccNumberTF.isHidden = true
        ccName.isHidden = true
        ccNameTF.isHidden = true
        ccExpiry.isHidden = true
        ccExpiryTF.isHidden = true
        ccCVV.isHidden = true
        ccCVVTF.isHidden = true
        ccAmount.isHidden = true
        ccAmountTF.isHidden = true
        ccAddToWallet.isHidden = true
        homePage.isHidden = true
        bookingPage.isHidden = true
        
        balance.text = "$\(userBalance)"
    }

    @IBAction func clickAddAmount(_ sender: Any) {
        ccTitle.isHidden = false
        ccNumber.isHidden = false
        ccNumberTF.isHidden = false
        ccName.isHidden = false
        ccNameTF.isHidden = false
        ccExpiry.isHidden = false
        ccExpiryTF.isHidden = false
        ccCVV.isHidden = false
        ccCVVTF.isHidden = false
        ccAmount.isHidden = false
        ccAmountTF.isHidden = false
        ccAddToWallet.isHidden = false
    }
    
    @IBAction func clickAddToWallet(_ sender: Any) {
        if let number = ccNumberTF.text, let name = ccNameTF.text, let expiry = ccExpiryTF.text, let cvv = ccCVVTF.text, let amount = ccAmountTF.text {
            if(number == "" || name == "" || expiry == "" || cvv == "" || amount == ""){
                openAlert(title: "Alert", message: "Please enter value for all fields.", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                return
            } else {
                if !number.validateCCnumber(){
                    openAlert(title: "Alert", message: "Please enter valid Credit card number.", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                    return
                }
                if !name.validName(){
                    openAlert(title: "Alert", message: "Please enter valid name.", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                    return
                }
                if !cvv.validateCCcvv(){
                    openAlert(title: "Alert", message: "Please enter valid CVV for credit card.", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                    return
                }
                if !amount.validateAmount(){
                    openAlert(title: "Alert", message: "Please do not enter more than $1000.0", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                    return
                }
                userBalance += Double(amount)!
                balance.text = "$\(userBalance)"
                
                ccTitle.isHidden = true
                ccNumber.isHidden = true
                ccNumberTF.isHidden = true
                ccName.isHidden = true
                ccNameTF.isHidden = true
                ccExpiry.isHidden = true
                ccExpiryTF.isHidden = true
                ccCVV.isHidden = true
                ccCVVTF.isHidden = true
                ccAmount.isHidden = true
                ccAmountTF.isHidden = true
                ccAddToWallet.isHidden = true
                if isFromSearchBus{
                    homePage.isHidden = false
                }
                if isFromBusDetail{
                    bookingPage.isHidden = false
                }
                openAlert(title: "Information", message: "Your account has been credited with $\(amount)", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sbvc = segue.destination as? SearchBusViewController
        sbvc?.userBalance = userBalance
        
        let bdvc = segue.destination as? BusDetailViewController
        bdvc?.userBalance = userBalance
        bdvc?.name = name
        bdvc?.images = images
        bdvc?.information = information
        bdvc?.from = from
        bdvc?.to = to
        bdvc?.price = price
        bdvc?.totalPrice = totalPrice
        bdvc?.isFood = isFood
        bdvc?.isLiveTracking = isLiveTracking
        bdvc?.isNetflix = isNetflix
        bdvc?.isElectricPlug = isElectricPlug
        bdvc?.isAc = isAc
        bdvc?.isSleeper = isSleeper
        bdvc?.numberOfSeats = numberOfSeats
    }
    
    @IBAction func clickHomePage(_ sender: Any) {
        performSegue(withIdentifier: "HomePageToSearchBus", sender: self)
    }
    
    @IBAction func clickBookingPage(_ sender: Any) {
        performSegue(withIdentifier: "BookingPageToBusDetail", sender: self)
    }
    
    
}
