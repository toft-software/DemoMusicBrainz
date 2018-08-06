//
//  Modal.swift
//  myMusicLocator
//
//  Created by Christian Andersen on 03/08/2018.
//  Copyright © 2018 Christian Andersen. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics



class Modal
{
    var blurBGImageView : UIImageView
    var _viewController : UIViewController!
    var headerTitle : UILabel
    var _oldTitle : String!
    var scrollModalView : UIScrollView
    var modalView : UIView
    var navView : UIView
    var blurBGView : UIView
    var doneModal : UIButton!
    var closeModal : UIButton
    
    init(customView : UIView, title : String,  viewController : UIViewController) {
        _viewController = viewController
        
        // The scroll view behind the modal view
        scrollModalView = UIScrollView()
        scrollModalView.frame = CGRect(x :0, y: (viewController.navigationController?.navigationBar.frame.maxY)!, width :viewController.view.frame.width, height : viewController.view.frame.height - viewController.navigationController!.navigationBar.frame.maxY)
        scrollModalView.bounces = true
        scrollModalView.scrollsToTop = false
        scrollModalView.alwaysBounceVertical = true
    
        // The overall master modal view
        modalView = UIView();
        modalView.frame = CGRect(x:(viewController.view.frame.width-280)/2,y: 5, width:280, height: 330)
        modalView.backgroundColor = UIColor.white
        modalView.layer.masksToBounds = false
        modalView.layer.cornerRadius = 5
        modalView.layer.shadowOffset = CGSize(width :0, height :0)
        modalView.layer.shadowRadius = 1
        modalView.layer.shadowOpacity = 1
    
        // A view that will disable the ability to press the buttons in the navbar.
        navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width :viewController.view.frame.width, height: (viewController.navigationController?.navigationBar.frame.height)!)
        navView.alpha = 0
    
        // A label to replace the navbar title
        headerTitle = UILabel()
        headerTitle.text = title
        headerTitle.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        headerTitle.textColor = UIColor.white
        headerTitle.sizeToFit()
        headerTitle.frame = CGRect(x: (viewController.view.frame.width-headerTitle.frame.width)/2, y: 6, width :headerTitle.frame.width, height: headerTitle.frame.height)
        headerTitle.alpha = 0
    
        // A image overlay to add a blur effect over the content behind the modal view.
        blurBGImageView = UIImageView()
        blurBGImageView.frame = CGRect(x: 0, y: 0, width : viewController.view.frame.width, height : viewController.view.frame.height)
    
        // This makes sure we have the coordinates relative to the backgroundView. Without this, the image drawn
        // for the button would be at the incorrect place of the background.
        let blurBGImageViewRectInBGViewCoords = blurBGImageView.convert(blurBGImageView.bounds, to: viewController.view)
        UIGraphicsBeginImageContextWithOptions (blurBGImageView.frame.size, false, UIScreen.main.scale)
        // Make a new image of the backgroundView (basically a screenshot of the view)
        viewController.view.drawHierarchy (in: CGRect (x: -blurBGImageViewRectInBGViewCoords.minX, y: -blurBGImageViewRectInBGViewCoords.minY,
                                                       width :viewController.view.frame.width, height :viewController.view.frame.height), afterScreenUpdates: true)
        let newblurBGImageViewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        // Apply the blur effect
       // newblurBGImageViewImage = newblurBGImageViewImage.ApplyDarkEffect();
    
        blurBGImageView.image = newblurBGImageViewImage
        blurBGImageView.layer.masksToBounds = true
    
        // The blur view
        blurBGView = UIView()
        blurBGView.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height : viewController.view.frame.height)
        blurBGView.alpha = 0
        blurBGView.addSubview(blurBGImageView)
    
    
        // A button to dismiss the modal view.
        closeModal = UIButton(type: UIButtonType.custom)
        closeModal.setTitle("Cancel", for: UIControlState.normal)
        closeModal.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        closeModal.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        closeModal.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size :16)
        closeModal.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        closeModal.sizeToFit ()
        closeModal.frame = CGRect(x :10, y:0, width : closeModal.frame.width, height: 40);

        closeModal.addTarget(self, action: #selector(actionCancel(sender:)), for: .touchUpInside)
        
        
        // A button to save the task or action.
        doneModal = UIButton(type :UIButtonType.custom)
        doneModal.setTitle("Save", for: UIControlState.normal)
        doneModal.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        doneModal.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        doneModal.titleLabel?.font = UIFont(name : "HelveticaNeue-Light", size :16)
        doneModal.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        doneModal.sizeToFit()
        doneModal.frame = CGRect(x : modalView.frame.width - doneModal.frame.width - 10, y: 0, width: 40, height :40)
    
        // A horizontal line to separate the buttons from the custom view.
        let line  = UIView ()
        line.backgroundColor = UIColor.darkGray
        line.frame = CGRect(x :10, y :closeModal.frame.maxY, width : modalView.frame.width-20, height:  1)
    
        customView.frame = CGRect(x :0, y: line.frame.maxY+2, width :modalView.frame.width, height : modalView.frame.height-line.frame.maxY-5)
        
        // Adding the views
        viewController.navigationController?.navigationBar.addSubview(navView)
        viewController.navigationController?.navigationBar.bringSubview(toFront: navView)
        viewController.navigationController?.navigationBar.addSubview(headerTitle)
        viewController.navigationController?.navigationBar.bringSubview(toFront: headerTitle)
    
        modalView.addSubview(closeModal);
        modalView.addSubview(doneModal);
        modalView.addSubview(line);
        modalView.addSubview(customView);
    
        scrollModalView.addSubview(modalView);
    
        blurBGView.addSubview(scrollModalView)
        viewController.view.addSubview(blurBGView)
    
        // Bringing them to the front in the correct order.
        viewController.view.bringSubview(toFront: blurBGView)
    
        // Save the Title of the ViewController.View in a string.
        _oldTitle = viewController.title!
        viewController.title = ""

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.navView.alpha = 1
            self.headerTitle.alpha = 1
            self.blurBGView.alpha = 1
        }, completion: nil)
}

    @objc func actionCancel(sender: UIButton)
    {
        self.CleanUp()
    }
    
    @objc func CleanUp() {
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
        self._viewController.navigationController?.navigationBar.tintColor = UIColor.white
        self.navView.alpha = 0
        self.headerTitle.alpha = 0
        self.blurBGView.alpha = 0
        }, completion: { (finished: Bool) in
        self.navView.removeFromSuperview()
        self._viewController.title = self._oldTitle
        self.headerTitle.removeFromSuperview()
        self.blurBGView.removeFromSuperview()
        })
    }
    
}

