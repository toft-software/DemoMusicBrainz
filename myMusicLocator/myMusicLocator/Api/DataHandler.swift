//
//  DataHandler.swift
//  myMusicLocator
//
//  Created by Christian Andersen on 02/08/2018.
//  Copyright © 2018 Christian Andersen. All rights reserved.
//

import Foundation


@objc class DataHandler: NSObject {
    
    static let queryTAG = "#query#"
    static let jsonUrlBaseString = "https://musicbrainz.org/ws/2/place/?query=?" + DataHandler.queryTAG +  "&limit=" + GlobalVariables.Limit + "&fmt=json"
    
    class func DoSearch(searchObj : SearchObject, completionBlock: @escaping (RootClass) -> Void) {
        let jsonUrlString = jsonUrlBaseString.replacingOccurrences(of: DataHandler.queryTAG, with: searchObj.SearchString)         
        guard let url = URL(string: jsonUrlString) else
        {return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else
            {return }
            print(data)
     
            do {
                let _courses = try JSONDecoder().decode(RootClass.self, from: data)
                
                completionBlock(_courses)
            } catch _ {
                print ("error serializing json")
                
            }
        }.resume()
    }
}
