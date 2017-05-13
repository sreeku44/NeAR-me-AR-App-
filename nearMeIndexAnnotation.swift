//
//  nearMeIndexAnnotation.swift
//  Near me AR App
//
//  Created by Sreekala Santhakumari on 5/4/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import Foundation
import HDAugmentedReality
import MapKit

class NearMeAnnotation : ARAnnotation {

    var nearMeRequest : NearMeRequest!
    
     init(nearMeRequest : NearMeRequest) {
       super.init()
        self.title = nearMeRequest.name
        self.location = CLLocation(latitude: nearMeRequest.coordinate.latitude, longitude: nearMeRequest.coordinate.longitude)
        self.nearMeRequest = nearMeRequest
    }

}

