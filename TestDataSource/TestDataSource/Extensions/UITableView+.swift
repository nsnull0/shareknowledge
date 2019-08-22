//
//  UITableView+.swift
//  TestDataSource
//
//  Created by Yoseph Wijaya on 2019/08/22.
//  Copyright © 2019 curcifer. All rights reserved.
//
import UIKit

extension UITableView {
  func register<T: ReusableProtocol & LoadableNIBProtocol>(_ : T.Type) {
    register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
  func dequeue<T: ReusableProtocol>(_ : T.Type) -> T? {
    return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T
  }
}
extension UITableViewCell: ReusableProtocol {}
extension UITableViewCell: LoadableNIBProtocol {}
protocol LoadableNIBProtocol {
  static var nib: UINib { get }
}
extension LoadableNIBProtocol where Self: UIView {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
  static func view() -> Self? {
    return nib.instantiate(withOwner: self, options: nil).first as? Self
  }
}
protocol ReusableProtocol {
  static var reuseIdentifier: String { get }
}
extension ReusableProtocol {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
