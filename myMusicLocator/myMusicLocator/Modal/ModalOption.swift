//
//  ModalOption.swift
//  myMusicLocator
//
//  Created by Christian Andersen on 03/08/2018.
//  Copyright © 2018 Christian Andersen. All rights reserved.
//

import Foundation
import UIKit


class ModalSearch
{
    
    fileprivate var searchObj : SearchObject!
    internal var searchdelegate : SearchPressedDelegate? = nil
    
    var optionProducinglabel : UILabel!
    var optionPerforminglabel : UILabel!
    var optionProducing : UISwitch!
    var optionPerforming : UISwitch!
    
    var searchView : UIView!
    var nameLabel : UILabel!
    
    var modal : Modal
    var paddingSide : CGFloat = 15
    var paddingTop : CGFloat = 10 

    init(viewController : UIViewController, searchObject : SearchObject)
    {
        self.searchObj = searchObject
               
        searchView = UIView()

        let modalTitle : String = "Search Music Location"
        modal = Modal(customView: searchView, title: modalTitle, viewController: viewController)
    
        modal.doneModal.addTarget(self, action: #selector(actionSearch(sender:)), for: .touchUpInside)
        
        let widthWithPadding = searchView.frame.width - paddingSide * 2
        var viewWidth = searchView.frame.width
        
        nameLabel = UILabel();
        nameLabel.frame = CGRect(x: paddingSide, y: paddingTop, width : widthWithPadding, height: 0);
        nameLabel.font = UIFont(name :"HelveticaNeue-Light", size : 17)
        nameLabel.text = "Comment:";
        nameLabel.sizeToFit();
        nameLabel.textColor = UIColor.darkGray
        
        optionPerforming = UISwitch()
        optionPerforming.frame = CGRect(x: searchView.frame.width - 44 - 10, y: paddingTop, width : 44, height :44)
        optionPerforming.isOn = searchObj.placeTypeExists(PlaceType.venue.rawValue) || searchObj.placeTypeExists(PlaceType.other.rawValue) 
        optionPerforming.addTarget(self, action: #selector(switchPerformingDidChange(_:)), for: .valueChanged)
        
        optionPerforminglabel = UILabel();
        optionPerforminglabel.text = "Performing music";
        optionPerforminglabel.sizeToFit();
        optionPerforminglabel.frame = CGRect(x: paddingSide, y: paddingTop+((optionPerforminglabel.frame.height-optionPerforminglabel.frame.height)/2), width : optionPerforminglabel.frame.width+10, height :optionPerforminglabel.frame.height)
        optionPerforminglabel.font = UIFont(name : "HelveticaNeue-Light", size : 17)
        optionPerforminglabel.textColor = UIColor.darkGray;
        
        optionProducing = UISwitch()
        optionProducing.frame = CGRect(x: searchView.frame.width - 44 - 10, y: optionPerforming.frame.maxY+paddingTop, width : 44, height :44)
        optionProducing.isOn = searchObj.placeTypeExists(PlaceType.studio.rawValue)
        optionProducing.addTarget(self, action: #selector(switchProducingDidChange(_:)), for: .valueChanged)                              
        
        optionProducinglabel = UILabel();
        optionProducinglabel.text = "Recording music";
        optionProducinglabel.sizeToFit();
        optionProducinglabel.font = UIFont(name: "HelveticaNeue-Light", size: 17);
        optionProducinglabel.textColor = UIColor.darkGray;
        optionProducinglabel.frame = CGRect(x: paddingSide, y: (optionPerforming.frame.maxY + paddingTop)+((optionPerforming.frame.height-optionPerforminglabel.frame.height)/2), width:  optionProducinglabel.frame.width+10, height : optionProducinglabel.frame.height)
        
        searchView.addSubview(optionPerforminglabel)
        searchView.addSubview(optionPerforming)
        searchView.addSubview(optionProducinglabel)
        searchView.addSubview(optionProducing)
        
        searchView.frame = CGRect(x :searchView.frame.minX, y: searchView.frame.minY, width :searchView.frame.width, height: optionProducinglabel.frame.maxY + 20)
        modal.modalView.frame = CGRect(x: modal.modalView.frame.minX, y: modal.modalView.frame.minY, width :modal.modalView.frame.width, height :searchView.frame.height + searchView.frame.minY)
        modal.scrollModalView.contentSize = CGSize(width:  modal.scrollModalView.frame.width, height :modal.modalView.frame.height + 30)
    }
    
    @objc func actionSearch(sender: UIButton)
    {
        self.modal.CleanUp()
       
        if (searchdelegate != nil) {
            searchdelegate!.SearchPressed(self.searchObj)
        }
    }
    
    func difficultyPressed ( _ sender : UIButton ){

    }
    
    //skal refactoreres
    @objc func switchProducingDidChange(_ sender: UISwitch) {
        searchObj.addPlaceType(placeType:PlaceType.studio.rawValue)
    }
    
    @objc func switchPerformingDidChange(_ sender: UISwitch) {
        searchObj.addPlaceType(placeType:PlaceType.other.rawValue)
        searchObj.addPlaceType(placeType:PlaceType.venue.rawValue)
        
    }
    
}


