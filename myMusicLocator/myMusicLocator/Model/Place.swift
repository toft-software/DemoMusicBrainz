//
//  Place.swift
//  Created on August 2, 2018

import Foundation
import MapKit


class Place : NSObject, Decodable{

    var address : String!
    var area : Area!
    var coordinates : Coordinate!
    var id : String!
    var lifeSpan : LifeSpan!
    var name : String!
    var score : Int!
    var type : String!
    var typeId : String!

    private enum CodingKeys: String, CodingKey {
        case name
        case address
        case area
        case coordinates
    }
    
    
    
}
