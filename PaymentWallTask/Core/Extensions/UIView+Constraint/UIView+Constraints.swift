//
//  UIView+Constraints.swift
//  InstagramCourse
//
//  Created by SAMEH on 9/13/18.
//  Copyright © 2018 sameh. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, _ bottom: NSLayoutYAxisAnchor? = nil, _ leading: NSLayoutXAxisAnchor? = nil, _ trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding?.top ?? 0).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding?.bottom ?? 0).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding?.left ?? 0).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding?.right ?? 0).isActive = true
        }
                
    }
    
    func addWidthConstraints(width: CGFloat?) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let width = width, width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func addHeightConstraints(height: CGFloat?) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height, height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func addCenterConstraints(vertical: NSLayoutYAxisAnchor? = nil, horizontal: NSLayoutXAxisAnchor? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let vertical = vertical {
            centerYAnchor.constraint(equalTo: vertical).isActive = true
        }
        
        if let horizontal = horizontal {
            centerXAnchor.constraint(equalTo: horizontal).isActive = true
        }
    }
}
