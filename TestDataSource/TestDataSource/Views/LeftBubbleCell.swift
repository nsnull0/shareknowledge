//
//  LeftBubbleCell.swift
//  TestDataSource
//
//  Created by Yoseph Wijaya on 2019/08/22.
//  Copyright © 2019 curcifer. All rights reserved.
//

import UIKit

class LeftBubbleCell: UITableViewCell {
  
  @IBOutlet private weak var borderView: UIView!
  @IBOutlet private weak var contentText: UILabel!
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
