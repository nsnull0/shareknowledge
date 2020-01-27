//
//  tableViewCell.swift
//  testchecktableui
//
//  Created by yoseph.savianto on 2020/01/24.
//  Copyright © 2020 yoseph.savianto. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    private var timer: Timer!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .white
    }

    deinit {
        deinitTrigger()
    }

}

extension TableViewCell: AdvertisementCountProtocol {
    func prepareTrigger() {
        guard timer.isValid, timer != nil  else { return }
        self.backgroundColor = .lightGray
    }

    func deinitTrigger() {
        timer.invalidate()
        timer = nil
    }

    func updateCell() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self] _ in
            self?.prepareTrigger()
        })
    }
}
