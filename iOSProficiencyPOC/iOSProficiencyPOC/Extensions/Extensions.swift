//
//  Extensions.swift
//  iOSProficiencyPOC
//
//  Created by Soham Bhowmik on 05/09/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsToOverlap(superView: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    func addConstraintsToOverlap(superView: UIView, leadingMargin leading:CGFloat, trailingMargin trailing: CGFloat, topMargin top: CGFloat, bottomMargin bottom: CGFloat)
    {
        translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: trailing).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottom).isActive = true
    }
    
    func addConstraints(superView: UIView, originX x:CGFloat, originY y: CGFloat, width: CGFloat, height: CGFloat)
    {
        translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: y).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: x).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func showLoader() -> Void {
        
        var loaderView = self.viewWithTag(1014)
        self.isUserInteractionEnabled = false
        if loaderView == nil {
            
            loaderView = UIView.init()
            loaderView!.tag = 1014
            loaderView!.translatesAutoresizingMaskIntoConstraints = false
            loaderView!.backgroundColor = Constants.Colors.transperentBlackColor
            loaderView!.layer.cornerRadius = 3.0;
            loaderView!.layer.masksToBounds = true;
            
            let activityIndicator = UIActivityIndicatorView.init(style: .white)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.tag = 1015
            loaderView!.addSubview(activityIndicator)
            activityIndicator.widthAnchor.constraint(equalToConstant: 20.0)
            activityIndicator.heightAnchor.constraint(equalToConstant: 20.0)
            activityIndicator.centerXAnchor.constraint(equalTo: loaderView!.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: loaderView!.centerYAnchor).isActive = true
            
            self.addSubview(loaderView!)
            loaderView!.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
            loaderView!.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            loaderView!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loaderView!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            activityIndicator.startAnimating()
            loaderView!.setNeedsLayout()
            loaderView!.layoutIfNeeded()
        }
        else {
            
            self.bringSubviewToFront(loaderView!)
        }
    }
    
    func removeLoader() -> Void {
        
        self.isUserInteractionEnabled = true
        let loaderView = self.viewWithTag(1014)
        let activityIndicator = loaderView?.viewWithTag(1015) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        loaderView?.removeFromSuperview()
    }
    
}
