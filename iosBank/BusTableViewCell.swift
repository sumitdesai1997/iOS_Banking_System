//
//  BusTableViewCell.swift
//  iosBank
//
//  Created by Sumit Desai on 12/26/1399 AP.
//

import UIKit

class BusTableViewCell: UITableViewCell {

    @IBOutlet weak var busName: UILabel!
    @IBOutlet weak var busPrice: UILabel!
    @IBOutlet weak var busRating: UILabel!
    
    
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
        busPrice.text = "$\(bus.price)"
        busRating.text = "\(bus.review) stars"
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
