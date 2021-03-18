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
    
    var name = ""
    var images = [String]()
    var information = ""
    var from = ""
    var to = ""
    var price = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        busName.text = name
        busImages.image = UIImage(named: images[0])
        busInformation.text = information
        number.text = String(1)
        ticketPrice.text = "$\(price)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changedNumber(_ sender: UIStepper) {
        number.text = String(Int(sender.value))
    }
    
}
