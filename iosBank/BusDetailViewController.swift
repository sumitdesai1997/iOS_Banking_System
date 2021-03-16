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
    
    var name = ""
    var images = [String]()
    var information = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        busName.text = name
        busImages.image = UIImage(named: images[0])
        busInformation.text = information
        number.text = String(1)
        // Do any additional setup after loading the view.
    }
}
