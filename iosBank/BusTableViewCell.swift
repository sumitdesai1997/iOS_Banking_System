//
//  BusTableViewCell.swift
//  iosBank
//
//  Created by Sumit Desai on 12/26/1399 AP.
//

import UIKit

class BusTableViewCell: UITableViewCell {

    @IBOutlet weak var busName: UILabel!
    @IBOutlet weak var isExpress: UILabel!
    @IBOutlet weak var isSleeper: UILabel!
    @IBOutlet weak var hasAC: UILabel!
    @IBOutlet weak var hasWifi: UILabel!
    @IBOutlet weak var reviews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusCell (bus: Bus){
        busName.text = bus.busName
        isExpress.text = bus.isExpress ? "Express" : "Non Express"
        isSleeper.text = bus.isSleeper ? "Sleeper" : "Seater"
        hasAC.text = bus.hasAC ? "AC" : "Non AC"
        hasWifi.text = bus.hasWifi ? "Wifi" : "No Wifi"
    }
    
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.origin.x += 10
            frame.size.height -= 15
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }

}
