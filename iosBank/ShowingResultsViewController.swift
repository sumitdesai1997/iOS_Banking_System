//
//  ShowingResultsViewController.swift
//  iosBank
//
//  Created by Sumit Desai on 12/26/1399 AP.
//

import UIKit

class ShowingResultsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = busTable.dequeueReusableCell(withIdentifier: "busCell") as! BusTableViewCell
        let bus = busList[indexPath.row]
        cell.setBusCell(bus: bus)
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        let borderColor: UIColor = .gray
        cell.layer.borderColor = borderColor.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = busList[indexPath.row].busName
        images = busList[indexPath.row].images
        information = busList[indexPath.row].description
        
        performSegue(withIdentifier: "BusListToBusDetail", sender: self)
    }
    
    @IBOutlet weak var busTable: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var busList = [Bus]()
    var from = ""
    var to = ""
    var name = ""
    var images = [String]()
    var information = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        busTable.dataSource = self
        busTable.delegate = self
        busTable.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        
        fillData()
        tableHeight.constant = CGFloat(Double(busList.count) * 110.0)
    }
    
    func fillData(){
        busList.append(Bus(busName: "Sumit Dhanadhan Travells", isExpress: true, isSleeper: true, hasAC: true, hasWifi: true, images: ["sumit1","sumit2","sumit3"], description: "One of the top buses in IndiaOne of the top buses in IndiaOne of the top buses in IndiaOne of the top buses in IndiaOne of the top buses in IndiaOne of the top buses in IndiaOne of the top buses in India.", from: [], to: [], review: 10.0))
        busList.append(Bus(busName: "Mihin Vana Wow Wow Travells", isExpress: true, isSleeper: false, hasAC: false, hasWifi: false, images: ["mihin1","mihin2","mihin3"], description: "One of the top buses in Gujarat", from: [], to: [], review: 9.0))
        busList.append(Bus(busName: "Krishna Canada Travells", isExpress: false, isSleeper: false, hasAC: false, hasWifi: true, images: ["krishna1","krishna2","krishna3"], description: "One of the top buses in Canada", from: [], to: [], review: 9.2))
        busList.append(Bus(busName: "Tulsi Express Travells", isExpress: true, isSleeper: true, hasAC: true, hasWifi: false, images: ["tulsi1","tulsi2","tulsi3"], description: "One of the top buses in Ahmedabad", from: [], to: [], review: 8.5))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bdvc = segue.destination as! BusDetailViewController
        
        bdvc.name = name
        bdvc.images = images
        bdvc.information = information
    }

}
