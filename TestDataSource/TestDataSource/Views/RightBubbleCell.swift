//
//  RightBubbleCell.swift
//  TestDataSource
//
//  Created by Yoseph Wijaya on 2019/08/22.
//  Copyright © 2019 curcifer. All rights reserved.
//

import UIKit

class RightBubbleCell: UITableViewCell {
  @IBOutlet private weak var contentText: UILabel!
  @IBOutlet private weak var borderView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    rotate(radian: .pi)
    borderView.layer.cornerRadius = 5
    borderView.layer.borderColor = UIColor.black.cgColor
    borderView.layer.borderWidth = 1
    selectionStyle = .none
  }
  
  func bind(data: String) {
    contentText.text = data
  }
}

