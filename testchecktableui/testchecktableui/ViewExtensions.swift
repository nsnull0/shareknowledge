//
//  ViewExtensions.swift
//  testchecktableui
//
//  Created by yoseph.savianto on 2020/01/24.
//  Copyright © 2020 yoseph.savianto. All rights reserved.
//

import UIKit

protocol AdvertisementCountProtocol {
    func updateCell()
    func prepareTrigger()
    func deinitTrigger()
}

extension UIViewController {
    static func instantiate<T: UIViewController>(_: T.Type, identifier: String = "", bundle: Bundle? = nil) -> T? {
        return UIStoryboard(name: "Main", bundle: bundle).instantiateViewController(identifier: identifier) as? T
    }
}


extension UITableView {

    func register<T: NibLoadableViewProtocol & ReusableViewProtocol>(_ : T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerCell<T: UITableViewCell>(_ : T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeue<T: ReusableViewProtocol>(_ : T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T
    }

}

extension UITableViewCell: NibLoadableViewProtocol {}
extension UITableViewCell: ReusableViewProtocol {}

protocol NibLoadableViewProtocol {
    static var nib: UINib { get }
}

extension NibLoadableViewProtocol where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static func view() -> Self? {
        return nib.instantiate(withOwner: self, options: nil).first as? Self
    }
}

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: NibLoadableViewProtocol & ReusableViewProtocol>(_ : T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeue<T: ReusableViewProtocol>(_ T: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}

extension UICollectionViewCell: NibLoadableViewProtocol {}
extension UICollectionViewCell: ReusableViewProtocol {}
