//
//  BusDetailViewController.swift
//  iosBank
//
//  Created by Sumit Desai on 12/26/1399 AP.
//

import UIKit

class BusDetailViewController: UIViewController {
    
    @IBOutlet weak var busName: UILabel!
    @IBOutlet weak var busImages: UIImageView!
    @IBOutlet weak var busInformation: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var liveTracking: UIButton!
    @IBOutlet weak var netflix: UIButton!
    @IBOutlet weak var electricPlug: UIButton!
    @IBOutlet weak var ac: UIButton!
    @IBOutlet weak var sleeper: UIButton!
    
    var user = User(name: "test", email: "test123@gmail.com", password: "12345678q", question: "buzzo", balance: 70.0)
    var name = ""
    var images = [String]()
    var information = ""
    var from = ""
    var to = ""
    var price = 0.0
    var tempPrice = 0.0
    var extraService = 0.0
    var numberSeatPrice = 0.0
    var travelDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        busName.text = name
        busImages.image = UIImage(named: images[0])
        busInformation.text = information
        number.text = String(1)
        ticketPrice.text = "$\(price)"
        tempPrice = price
        numberSeatPrice = price
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changedNumber(_ sender: UIStepper) {
        number.text = String(Int(sender.value))
        price = tempPrice * Double(number.text!)!
        numberSeatPrice = price
        ticketPrice.text = "$\(price)"
        
        extraService = 0.0
        food.isSelected = false
        liveTracking.isSelected = false
        netflix.isSelected = false
        electricPlug.isSelected = false
        ac.isSelected = false
        sleeper.isSelected = false
    }
    
    @IBAction func clickFood(_ sender: Any) {
        if(food.isSelected){
            food.isSelected = false
            //extraService -= (2.0 * Double(numberOfSeat))
            //price -= extraService
            //ticketPrice.text = "$\(price)"
        } else {
            food.isSelected = true
            //extraService += (2.0 * Double(numberOfSeat))
            //price += extraService
            //ticketPrice.text = "$\(price)"
        }
        getExtraService()
    }
    
    @IBAction func clickLiveTracking(_ sender: Any) {
        if(liveTracking.isSelected){
            liveTracking.isSelected = false
            //extraService -= (0.25 * Double(numberOfSeat))
            //price -= extraService
            //ticketPrice.text = "$\(price)"
        } else {
            liveTracking.isSelected = true
            //extraService += (0.25 * Double(numberOfSeat))
            //price += extraService
            //ticketPrice.text = "$\(price)"
        }
        getExtraService()
    }
    
    @IBAction func clickNetflix(_ sender: Any) {
        if(netflix.isSelected){
            netflix.isSelected = false
            //extraService -= (1.0 * Double(numberOfSeat))
            //price -= extraService
            //ticketPrice.text = "$\(price)"
        } else {
            netflix.isSelected = true
            //extraService += (1.0 * Double(numberOfSeat))
            //price += extraService
            //ticketPrice.text = "$\(price)"
        }
        getExtraService()
    }
    
    @IBAction func clickElectricPlug(_ sender: Any) {
        if(electricPlug.isSelected){
            electricPlug.isSelected = false
            //extraService -= (0.50 * Double(numberOfSeat))
            //price -= extraService
            //ticketPrice.text = "$\(price)"
        } else {
            electricPlug.isSelected = true
            //extraService += (0.50 * Double(numberOfSeat))
            //price += extraService
            //ticketPrice.text = "$\(price)"
        }
        getExtraService()
    }
    
    @IBAction func clickAC(_ sender: Any) {
        if(ac.isSelected){
            ac.isSelected = false
            //extraService -= (1.0 * Double(numberOfSeat))
            //price -= extraService
            //ticketPrice.text = "$\(price)"
        } else {
            ac.isSelected = true
            //extraService += (1.0 * Double(numberOfSeat))
            //price += extraService
            //ticketPrice.text = "$\(price)"
        }
        getExtraService()
    }
    
    @IBAction func clickSleeper(_ sender: Any) {
        if(sleeper.isSelected){
            sleeper.isSelected = false
            //extraService -= (price * Double(numberOfSeat))
            //price -= extraService
            //ticketPrice.text = "$\(price)"
        } else {
            sleeper.isSelected = true
            //extraService += (price * Double(numberOfSeat))
            //price += extraService
            //ticketPrice.text = "$\(price)"
        }
        getExtraService()
    }
    
    func getExtraService(){
        extraService = 0.0
        price = numberSeatPrice
        
        let numberOfSeat = Int(number.text!)!
        
        if food.isSelected{
            extraService += 2.0 * Double(numberOfSeat)
        }
        if liveTracking.isSelected{
            extraService += 0.50 * Double(numberOfSeat)
        }
        if netflix.isSelected{
            extraService += 1.0 * Double(numberOfSeat)
        }
        if electricPlug.isSelected{
            extraService += 0.25 * Double(numberOfSeat)
        }
        if ac.isSelected{
            extraService += 0.75 * Double(numberOfSeat)
        }
        if sleeper.isSelected{
            extraService += 3.0 * Double(numberOfSeat)
        }
        
        price += extraService
        ticketPrice.text = "$\(price)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bcvc = segue.destination as! BookingConfirmationViewController
        var serviceDetails = ""
        
        if(food.isSelected){
            serviceDetails += "Food,"
        }
        if(liveTracking.isSelected){
            serviceDetails += "Live Tracking,"
        }
        if(netflix.isSelected){
            serviceDetails += "Netflix,"
        }
        if(electricPlug.isSelected){
            serviceDetails += "Electric plug,"
        }
        if(ac.isSelected){
            serviceDetails += "AC,"
        }
        if(sleeper.isSelected){
            serviceDetails += "Sleeper"
        }
        
        bcvc.userName = user.name
        bcvc.fromCity = from
        bcvc.toCity = to
        bcvc.busname = name
        bcvc.numberOfSeats = number.text!
        bcvc.services = serviceDetails
        bcvc.totalPayment = String(price)
        bcvc.travelDate = travelDate
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let finalPrice = price
        
        if(finalPrice > user.balance){
            print(user.balance)
            return false
        }
        return true
    }
    
    @IBAction func clickBookTicket(_ sender: Any) {
        if(shouldPerformSegue(withIdentifier: "BusDetailToBookingConfirm", sender: self)){
            performSegue(withIdentifier: "BusDetailToBookingConfirm", sender: self)
        }
        else {
            openAlert(title: "Alert", message: "Your account don't have sufficent amount to book the ticket!", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
        }
    }
    
}
