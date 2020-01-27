//
//  collectionViewCell.swift
//  testchecktableui
//
//  Created by yoseph.savianto on 2020/01/24.
//  Copyright © 2020 yoseph.savianto. All rights reserved.
//

import UIKit

class CViewCell: UICollectionViewCell {

    @IBOutlet weak var labelmain: UILabel!
    @IBOutlet private weak var backzView: UIView!
    private var timer: Timer!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.backzView.backgroundColor = .green
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.backzView.backgroundColor = .green
    }

    deinit {
        deinitTrigger()
    }
}


extension CViewCell: AdvertisementCountProtocol {
    func prepareTrigger() {
        guard timer.isValid, timer != nil  else { return }
        self.backzView.backgroundColor = .lightGray
    }

    func deinitTrigger() {
        guard timer != nil else { return }
        timer.invalidate()
        timer = nil
    }

    func updateCell() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self] _ in
            self?.prepareTrigger()
        })
    }
}
