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
        price = busList[indexPath.row].price
        performSegue(withIdentifier: "BusListToBusDetail", sender: self)
    }
    
    @IBOutlet weak var busTable: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var sortingSegment: UISegmentedControl!
    
    var user = User(name: "test", email: "test123@gmail.com", password: "12345678q", question: "buzzo", balance: 70.0)
    var userBalance = 0.0
    var busList = [Bus]()
    var from = ""
    var to = ""
    var name = ""
    var images = [String]()
    var information = ""
    var price = 0.0
    var travelDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        busTable.dataSource = self
        busTable.delegate = self
        busTable.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        
        tableHeight.constant = CGFloat(Double(busList.count) * 114.0)
        
        user.balance = userBalance
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bdvc = segue.destination as? BusDetailViewController
        
        bdvc?.user = user
        bdvc?.name = name
        bdvc?.images = images
        bdvc?.information = information
        bdvc?.from = from
        bdvc?.to = to
        bdvc?.price = price
        bdvc?.totalPrice = price
        bdvc?.travelDate = travelDate
        bdvc?.userBalance = userBalance
    }
    
    @IBAction func clickSegment(_ sender: Any) {
        let i = sortingSegment.selectedSegmentIndex
        
        if i == 0 {
            busList.sort(by: {$0.price < $1.price})
            busTable.reloadData()
        }
        if i == 1 {
            busList.sort(by: {$0.price > $1.price})
            busTable.reloadData()
        }
    }
}
