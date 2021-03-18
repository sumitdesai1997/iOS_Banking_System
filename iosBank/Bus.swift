//
//  Bus.swift
//  iosBank
//
//  Created by Sumit Desai on 12/26/1399 AP.
//

import Foundation

class Bus{
    var busName : String
    var isExpress : Bool
    var isSleeper : Bool
    var hasAC : Bool
    var hasWifi : Bool
    var images : [String]
    var description: String
    var from : [String]
    var to : [String]
    var review : Double
    var multiplier : Double
    
    init(busName: String, isExpress: Bool, isSleeper: Bool, hasAC: Bool, hasWifi: Bool, images: [String], description: String, from: [String], to: [String], review: Double, multiplier: Double) {
        self.busName = busName
        self.isExpress = isExpress
        self.isSleeper = isSleeper
        self.hasAC = hasAC
        self.hasWifi = hasWifi
        self.images = images
        self.description = description
        self.from = from
        self.to = to
        self.review = review
        self.multiplier = multiplier
    }
}
