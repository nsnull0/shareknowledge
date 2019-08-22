//
//  UIView+.swift
//  TestDataSource
//
//  Created by Yoseph Wijaya on 2019/08/23.
//  Copyright © 2019 curcifer. All rights reserved.
//

import UIKit

extension UIView {
  func rotate(radian: CGFloat) {
    transform = CGAffineTransform(rotationAngle: radian)
  }
}
