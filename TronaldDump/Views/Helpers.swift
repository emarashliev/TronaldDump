//
//  File.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import UIKit

extension UIView {
    func constrainEqual(attribute: NSLayoutAttribute,
                               to: AnyObject,
                               multiplier: CGFloat = 1,
                               constant: CGFloat = 0) {
        
        constrainEqual(attribute: attribute, to: to, attribute, multiplier: multiplier, constant: constant)
    }
    
    func constrainEqual(attribute: NSLayoutAttribute,
                               to: AnyObject,
                               _ toAttribute: NSLayoutAttribute,
                               multiplier: CGFloat = 1,
                               constant: CGFloat = 0) {
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
            ]
        )
    }
    
    func constrainEdges(toMarginOf view: UIView) {
        constrainEqual(attribute: .top, to: view, .topMargin)
        constrainEqual(attribute: .leading, to: view, .leadingMargin)
        constrainEqual(attribute: .trailing, to: view, .trailingMargin)
        constrainEqual(attribute: .bottom, to: view, .bottomMargin)
    }
    
    func center(inView view: UIView) {
        centerXAnchor.constrainEqual(anchor: view.centerXAnchor)
        centerYAnchor.constrainEqual(anchor: view.centerYAnchor)
    }
}

extension NSLayoutAnchor {
    @objc
    func constrainEqual(anchor: NSLayoutAnchor, constant: CGFloat = 0) {
        let aConstraint = constraint(equalTo: anchor, constant: constant)
        aConstraint.isActive = true
    }
}
