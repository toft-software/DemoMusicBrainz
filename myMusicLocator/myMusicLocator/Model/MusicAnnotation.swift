//
//  MusicAnnotation.swift
//  myMusicLocator
//
//  Created by Christian Andersen on 02/08/2018.
//  Copyright © 2018 Christian Andersen. All rights reserved.
//

import Foundation
import MapKit

final class MusicAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    init(coordinate : CLLocationCoordinate2D, title : String, subtitle : String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
}

