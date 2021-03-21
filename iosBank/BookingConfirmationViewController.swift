//
//  BookingConfirmationViewController.swift
//  iosBank
//
//  Created by Sumit Desai on 12/30/1399 AP.
//

import UIKit

class BookingConfirmationViewController: UIViewController {
    
    @IBOutlet weak var usernameL: UILabel!
    @IBOutlet weak var fromcityL: UILabel!
    @IBOutlet weak var tocityL: UILabel!
    @IBOutlet weak var traveldateL: UILabel!
    @IBOutlet weak var busnameL: UILabel!
    @IBOutlet weak var numberofseatsL: UILabel!
    @IBOutlet weak var servicesL: UILabel!
    @IBOutlet weak var totalpaymentL: UILabel!
    
    var userName = ""
    var userBalance = 0.0
    var fromCity = ""
    var toCity = ""
    var travelDate = Date()
    var busname = ""
    var numberOfSeats = ""
    var services = ""
    var totalPayment = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameL.text = userName
        fromcityL.text = fromCity
        tocityL.text = toCity
        traveldateL.text = ""
        busnameL.text = busname
        numberofseatsL.text = numberOfSeats
        servicesL.text = services
        totalpaymentL.text = String(totalPayment)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sbvc = segue.destination as? SearchBusViewController
        sbvc?.userBalance = userBalance - totalPayment
    }
    @IBAction func clickGoToHomePage(_ sender: Any) {
        performSegue(withIdentifier: "GoToHomePage", sender: self)
    }
}
