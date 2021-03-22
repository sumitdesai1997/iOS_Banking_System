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
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var liveTracking: UIButton!
    @IBOutlet weak var netflix: UIButton!
    @IBOutlet weak var electricPlug: UIButton!
    @IBOutlet weak var ac: UIButton!
    @IBOutlet weak var sleeper: UIButton!
   
    @IBOutlet weak var addAmount: UIButton!
    
    var user = User()
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
    var travelDate = Date()
    
    var isFood = false
    var isLiveTracking = false
    var isNetflix = false
    var isElectricPlug = false
    var isAc = false
    var isSleeper = false
    var numberOfSeats = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        busName.text = name
        busImages.image = UIImage(named: images[0])
        busInformation.text = information
        number.text = String(numberOfSeats)
        stepper.value = Double(numberOfSeats)
        tempPrice = price
        numberSeatPrice = price
        ticketPrice.text = "$\(String(format:"%.2f",totalPrice))"
        addAmount.isHidden = true
        // Do any additional setup after loading the view.
        
        food.isSelected = isFood
        liveTracking.isSelected = isLiveTracking
        netflix.isSelected = isNetflix
        electricPlug.isSelected = isElectricPlug
        ac.isSelected = isAc
        sleeper.isSelected = isSleeper
        
        print("Bus detail in: \(user.balance)")
    }
    
    @IBAction func changedNumber(_ sender: UIStepper) {
        number.text = String(Int(sender.value))
        numberSeatPrice = price * Double(number.text!)!
        totalPrice = numberSeatPrice
        ticketPrice.text = "$\(String(format:"%.2f",totalPrice))"
        
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
        } else {
            food.isSelected = true
        }
        getExtraService()
    }
    
    @IBAction func clickLiveTracking(_ sender: Any) {
        if(liveTracking.isSelected){
            liveTracking.isSelected = false
        } else {
            liveTracking.isSelected = true
        }
        getExtraService()
    }
    
    @IBAction func clickNetflix(_ sender: Any) {
        if(netflix.isSelected){
            netflix.isSelected = false
        } else {
            netflix.isSelected = true
        }
        getExtraService()
    }
    
    @IBAction func clickElectricPlug(_ sender: Any) {
        if(electricPlug.isSelected){
            electricPlug.isSelected = false
        } else {
            electricPlug.isSelected = true
        }
        getExtraService()
    }
    
    @IBAction func clickAC(_ sender: Any) {
        if(ac.isSelected){
            ac.isSelected = false
        } else {
            ac.isSelected = true
        }
        getExtraService()
    }
    
    @IBAction func clickSleeper(_ sender: Any) {
        if(sleeper.isSelected){
            sleeper.isSelected = false
        } else {
            sleeper.isSelected = true
        }
        getExtraService()
    }
    
    func getExtraService(){
        extraService = 0.0
        totalPrice = price * Double(number.text!)!
        
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
        
        totalPrice += extraService
        ticketPrice.text = "$\(String(format:"%.2f",totalPrice))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bcvc = segue.destination as? BookingConfirmationViewController
        var serviceDetails = ""
        
        if(food.isSelected){
            serviceDetails += "Food,"
        }
        if(liveTracking.isSelected){
            serviceDetails += " Live Tracking,"
        }
        if(netflix.isSelected){
            serviceDetails += " Netflix,"
        }
        if(electricPlug.isSelected){
            serviceDetails += " Electric plug,"
        }
        if(ac.isSelected){
            serviceDetails += " AC,"
        }
        if(sleeper.isSelected){
            serviceDetails += " Sleeper"
        }
        
        if !serviceDetails.contains("Sleeper"){
            serviceDetails = String(serviceDetails.dropLast())
        }
        
        if serviceDetails == "" {
            serviceDetails = "No extra service choosen"
        }
        
        bcvc?.userName = user.name
        bcvc?.fromCity = from
        bcvc?.toCity = to
        bcvc?.busname = name
        bcvc?.numberOfSeats = number.text!
        bcvc?.services = serviceDetails
        bcvc?.totalPayment = totalPrice
        bcvc?.travelDate = travelDate
        bcvc?.user = user
        
        let wvc = segue.destination as? WalletViewController
        wvc?.isFromBusDetail = true
        wvc?.user = user
        wvc?.name = name
        wvc?.images = images
        wvc?.information = information
        wvc?.from = from
        wvc?.to = to
        wvc?.price = price
        wvc?.totalPrice = totalPrice
        wvc?.isFood = food.isSelected
        wvc?.isLiveTracking = liveTracking.isSelected
        wvc?.isNetflix = netflix.isSelected
        wvc?.isElectricPlug = electricPlug.isSelected
        wvc?.isAc = ac.isSelected
        wvc?.isSleeper = sleeper.isSelected
        wvc?.numberOfSeats = Int(number.text!)!
        wvc?.travelDate = travelDate
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let finalPrice = totalPrice
        
        if(finalPrice > user.balance){
            addAmount.isHidden = false
            return false
        }
        addAmount.isHidden = true
        return true
    }
    
    @IBAction func clickBookTicket(_ sender: Any) {
        if(shouldPerformSegue(withIdentifier: "BusDetailToBookingConfirm", sender: self)){
            performSegue(withIdentifier: "BusDetailToBookingConfirm", sender: self)
        }
        else {
            openAlert(title: "Alert", message: "Your account don't have sufficent amount to book the ticket!", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [{ _ in}])
            return
        }
    }
    
    @IBAction func clickAddAmount(_ sender: Any) {
        performSegue(withIdentifier: "AddAmountToWallet", sender: self)
    }
    
    var i = 0
    @IBAction func clickRight(_ sender: Any) {
        if ((i + 1) < images.count) {
            busImages.image = UIImage(named: images[i+1])
            i += 1
        }
        
    }
    
    @IBAction func clickLeft(_ sender: Any) {
        if i > 0 {
            busImages.image = UIImage(named: images[i-1])
            i -= 1
        }
    }
    
}
