//
//  UIViewExtension.swift
//  ContainerView_SlideButton
//
//  Created by Thaliees on 6/17/19.
//  Copyright © 2019 Thaliees. All rights reserved.
//

import UIKit

extension UIView{
    func round() {
        layer.cornerRadius = CGFloat(20)
        clipsToBounds = true
    }
}
