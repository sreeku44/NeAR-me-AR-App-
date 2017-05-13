//
//  ViewController.swift
//  Near me AR App
//
//  Created by Sreekala Santhakumari on 3/14/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit
import MapKit
import HDAugmentedReality


protocol UserLocationDelegate {
    func userLocation(latitude :Double, longitude :Double)
}


class NearMeMapViewController: ARViewController, ARDataSource, MKMapViewDelegate, CLLocationManagerDelegate, SearchIndexDelegate {
    
    var nearMeIndexSelected = NearMeIndexTitle ()
    var locationManager : CLLocationManager!
    var nearMeARAnnotations = [ARAnnotation]()
    var nearMeRequests = [NearMeRequest]()
    var delegate : UserLocationDelegate!
    var searchText :String!
    
    
    
    //Annotation data
//    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
//        
//        let annotationView = ARAnnotationView()
//        annotationView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
//        annotationView.backgroundColor = UIColor.red
//        
//        //annotationView.textInputMode =
//        return annotationView
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationController color
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
        //title for the ViewController
        self.title = nearMeIndexSelected.indexTitle
        
        //location update with CLLocationManager
        self.locationManager = CLLocationManager ()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLHeadingFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.dataSource = self
        self.headingSmoothingFactor = 0.05
        self.maxVisibleAnnotations = 30
        
        getNearMeIndexSelectedLocation ()
        
        
        //                let arAnnotation = ARAnnotation()
        //                arAnnotation.location = mapItem.placemark.location
        //                arAnnotation.title = mapItem.placemark.name
        //
        //               // arAnnotation.distanceFromUser = mapItem.placemark.
        //
        //                self.nearMeARAnnotations.append(arAnnotation)
        //                self.setAnnotations(self.nearMeARAnnotations)
    }
    
    func searchIndexText  (searchText :String) {
        self.nearMeIndexSelected.indexTitle = searchText
    }

    
    func getNearMeIndexSelectedLocation ()
    {
        //To findount what is near me
        let nearMeRequest = MKLocalSearchRequest()
        nearMeRequest.naturalLanguageQuery = nearMeIndexSelected.indexTitle
        let nearMeregion = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 250, 250)
        nearMeRequest.region = nearMeregion
        let nearMeSearch = MKLocalSearch(request: nearMeRequest)
        nearMeSearch.start { (response : MKLocalSearchResponse?, error :Error?) in
            
            for requestItem in (response?.mapItems)!{
                
                let nearMeIndexRequest = NearMeRequest ()
                nearMeIndexRequest.name = requestItem.name
                nearMeIndexRequest.coordinate = requestItem.placemark.coordinate
                nearMeIndexRequest.address = requestItem.placemark.addressDictionary?["FormattedAddressLines"] as! [String]
                nearMeIndexRequest.street = requestItem.placemark.addressDictionary?["Street"] as! String!
                nearMeIndexRequest.city = requestItem.placemark.addressDictionary?["City"] as! String
                nearMeIndexRequest.state = requestItem.placemark.addressDictionary?["State"] as! String
                nearMeIndexRequest.zip = requestItem.placemark.addressDictionary?["ZIP"] as! String
                
                self.nearMeRequests.append(nearMeIndexRequest)
                print(requestItem.placemark.name) }
            
            for nearMe in self.nearMeRequests {
              
                let annotation = NearMeAnnotation(nearMeRequest: nearMe)
                self.nearMeARAnnotations.append(annotation)
                self.setAnnotations(self.nearMeARAnnotations)
 
            }
 
        }
 
    }
        func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let annotationView =  NearMeARAnnotationView(annotation: viewForAnnotation)
            
            
            return annotationView
    }
    
    
    
}



