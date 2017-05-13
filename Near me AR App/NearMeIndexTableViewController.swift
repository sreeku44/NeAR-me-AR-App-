//
//  NearMeIndexTableViewController.swift
//  Near me AR App
//
//  Created by Sreekala Santhakumari on 3/14/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import MapKit


protocol SearchIndexDelegate  {
    func searchIndexText(searchText : String)
}

class NearMeIndexTableViewController: UITableViewController, UISearchBarDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
   @IBOutlet weak var indexSearchBar: UISearchBar!
    var locationManager : CLLocationManager!
    var nearMeIndexes = [NearMeIndexTitle]()
    var delegate : SearchIndexDelegate!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
        let nearmeindex1 = NearMeIndexTitle()
        nearmeindex1.indexTitle = "Fast food"
        //nearmeindex1.imageName = "fastfood.jpg"
        
        let nearmeidex2 = NearMeIndexTitle()
        nearmeidex2.indexTitle = "Restaurants"
        //nearmeidex2.imageName = "restaurant.png"
        
        let nearmeindex3 = NearMeIndexTitle()
        nearmeindex3.indexTitle = "Gas stations"
       // nearmeindex3.imageName = "gas station.png"
        
        let nearmeidex4 = NearMeIndexTitle()
        nearmeidex4.indexTitle = "Hospitals"
        //nearmeidex4.imageName = "hospital.jpg"
        
        let nearmeindex5 = NearMeIndexTitle()
        nearmeindex5.indexTitle = "Park"
        //nearmeindex5.imageName = "park.png"
        
        let nearmeidex6 = NearMeIndexTitle()
        nearmeidex6.indexTitle = "Groceries"
        //nearmeidex6.imageName = "grocery.png"
        
        let nearmeindex7 = NearMeIndexTitle()
        nearmeindex7.indexTitle = "Museums"
        //nearmeindex7.imageName = "museum.ico"
        
        let nearmeidex8 = NearMeIndexTitle()
        nearmeidex8.indexTitle = "Car repairs"
        //nearmeidex8.imageName = "car.png"
        
        nearMeIndexes.append(nearmeindex1)
        nearMeIndexes.append(nearmeidex2)
        nearMeIndexes.append(nearmeidex6)
        nearMeIndexes.append(nearmeindex3)
        nearMeIndexes.append(nearmeindex5)
        nearMeIndexes.append(nearmeindex7)
        nearMeIndexes.append(nearmeidex8)
        nearMeIndexes.append(nearmeidex4)
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.indexSearchBar.delegate = self
        
        self.tableView.reloadData()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchText = String()
        searchText = self.indexSearchBar.text!
        self.delegate?.searchIndexText(searchText: searchText)
        self.performSegue(withIdentifier: "NearMeMapSegue", sender: self.delegate)
        print(searchText)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nearMeIndexes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearMeIndexCell", for: indexPath) as! NearMeTableViewCell
        
        let  nearMendexCellValue  = nearMeIndexes[indexPath.row]
        cell.nearMeLabel.text = nearMendexCellValue.indexTitle
        
//        let img = UIImage(named: nearMendexCellValue.imageName)
//        cell.nearMeImageView.image = img
        return cell
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NearMeMapSegue"{
            
            guard   let indexPath : IndexPath = self.tableView.indexPathForSelectedRow
            
            else{
                fatalError("no Selection made")
            }
            let selectedIndex = self.nearMeIndexes[indexPath.row]
            let nearMeVC = segue.destination as! NearMeMapViewController
            nearMeVC.nearMeIndexSelected = selectedIndex
        
        
        }
    }
}
       
