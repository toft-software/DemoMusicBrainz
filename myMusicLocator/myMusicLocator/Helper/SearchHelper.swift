//
//  SearchHelper.swift
//
//
//  Created by Christian Andersen on 15/03/2017.
//

import Foundation


protocol SearchPressedDelegate {
    func SearchPressed(_ SearchObj : SearchObject)
}

public enum PlaceType: String
{
    case studio
    case venue
    case other
    //NB der er flere typer som ikke er taget med
}

class SearchObject: NSObject {
    
    fileprivate var _text: String = ""
    fileprivate var _placeTypes: [String]
    
    override init(){
       _placeTypes = [String]()
    }
    
    
    private func addPlaceType(_ placeType : String) {
        _placeTypes.append(placeType)
    }
    
    private func removePlaceType(_ placeType : String) {
        if let index = self._placeTypes.index(of: placeType) {
            _placeTypes.remove(at: index)
        }
    }
 
    var searchTxt: String {
        get {
            return _text
        }
        set {
            _text = newValue
        }
    }
    
    public func addPlaceType (placeType : String) {
        if _placeTypes.contains(placeType) {
            self.removePlaceType(placeType)
        } else {
            self.addPlaceType(placeType)
        }
    }

    var SearchString: String {
        get {
            var searchType = ""
            var andTypes = false
            var count = 0
            for placeType in _placeTypes {
                if (!andTypes) {
                    searchType = "+AND+("
                    andTypes = true
                }
                if count > 0 {
                    searchType = searchType + "+OR+"
                }
                searchType = searchType + "type:"+placeType
                count += 1
            }
            if (andTypes) {
                searchType = searchType + ")"
            }
            return searchType
        }
    }
    
    func placeTypeExists(_ placeType : String) -> Bool {
        if self._placeTypes.index(of: placeType) != nil {
            return true
        }
        return false
    }

}

