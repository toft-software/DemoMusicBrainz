//
//  ViewController.swift
//  myMusicLocator
//
//  Created by Christian Andersen on 01/08/2018.
//  Copyright © 2018 Christian Andersen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, SearchPressedDelegate {


    @IBOutlet var mapView: MKMapView!
    var modalSearch : ModalSearch!
    fileprivate var searchObj : SearchObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.register(MKMarkerAnnotationView.self,  forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        let barButtonSearch = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(actionSearch(sender:)))
        self.navigationItem.setRightBarButtonItems([barButtonSearch], animated: true)
        
        self.searchObj = SearchObject()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func actionSearch(sender: UIBarButtonItem)
    {
        modalSearch = ModalSearch(viewController: self, searchObject: searchObj)
        modalSearch.searchdelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let musicAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView
        {
            musicAnnotationView.animatesWhenAdded = true
            musicAnnotationView.titleVisibility = .adaptive
            return musicAnnotationView
        }
        return nil
    }
    
    //search delegate
    func SearchPressed(_ searchObj: SearchObject) {
        DataHandler.DoSearch(searchObj: searchObj) { (RootClass) in
            var arrMusicAnnotation = [MusicAnnotation].init()
            for place in RootClass.places {

                if (place.coordinates != nil)
                {
                    if let lat = Double(place.coordinates.latitude!), let long = Double(place.coordinates.longitude!) {
                        let musicAnnotation = MusicAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long), title: place.name, subtitle: "")

                        arrMusicAnnotation.append(musicAnnotation)
                    }
                }

            }
            if (arrMusicAnnotation.count>0) {
                self.mapView.addAnnotations(arrMusicAnnotation)
                self.mapView.showAnnotations(arrMusicAnnotation, animated: true)

            }
        }
    }

}


