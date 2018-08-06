//
//  MusicLocation.swift
//  myMusicLocator
//
//  Created by Christian Andersen on 01/08/2018.
//  Copyright © 2018 Christian Andersen. All rights reserved.
//

import Foundation


struct Coordinates: Decodable {
    var latitude : Float?
    var longitude : Float?
   
    /*
    init(json : [String : Any] ) {
        latitude = json["latitude"] as! Float
        longitude = json["longitude"] as! Float
    }*/
    
}

struct Place: Decodable {
    
    var id : String?
    var name: String?
    var type: String?
    var address : String?
  //  var coordinates: Coordinates?

}

struct PlaceCollection : Decodable {
    let created : String?
    let count : String?
    let offset : String?
 //   var places : [Place]?
    

}
