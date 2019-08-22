//
//  ViewController.swift
//  TestDataSource
//
//  Created by Yoseph Wijaya on 2019/08/22.
//  Copyright © 2019 curcifer. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ViewController: UIViewController {
  private var dataSources = RxTableViewSectionedReloadDataSource<MainViewModel.BubbleItemSectionCell>(configureCell: {
    (ds, tableView, indexPath, item) -> UITableViewCell in
    switch item {
    case .rightBubbleText(let content):
      let cell = tableView.dequeue(RightBubbleCell.self)!
      cell.bind(data: content.text)
      return cell
    case .leftBubbleText(let content):
      let cell = tableView.dequeue(LeftBubbleCell.self)!
      cell.bind(data: content.text)
      return cell
    }
  })
  @IBOutlet private weak var leftPostButtonBubble: UIButton!
  @IBOutlet private weak var inputField: UITextField!
  @IBOutlet private weak var rightPostButtonBubble: UIButton!
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
  private var keyboardHeight: Observable<CGFloat> = Observable.empty()
  private var viewModel: MainViewModel!
  private var disposeBag: DisposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = MainViewModel()
    tableView.rotate(radian: .pi)
    tableView.estimatedRowHeight = 60
    tableView.register(LeftBubbleCell.self)
    tableView.register(RightBubbleCell.self)
    tableView.separatorStyle = .none
    keyboardHeight = Observable.from([NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).map { v -> CGFloat in
      if let heightValue = v.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        return heightValue.cgRectValue.height + 50
      }
      return 50
      },
      NotificationCenter
        .default.rx
        .notification(UIResponder.keyboardWillHideNotification)
        .map { _ -> CGFloat in
          return 50
      }
    ]).merge()
    
    keyboardHeight
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] v in
        UIView.animate(withDuration: 0.3) {
          self?.bottomConstraint.constant = v
          self?.view.layoutIfNeeded()
        }
    }).disposed(by: disposeBag)
    
    //since it is reverse so this is right and vice versa
    rightPostButtonBubble
      .rx.tap.asDriver()
      .drive(onNext: {
      [weak self] _ in
        if let value = self?.inputField.text {
          let leftBubbleItem = MainViewModel.ContentBubbleItem(text: value, name: "Left")
          self?.viewModel
            .itemPushRelay.accept(MainViewModel.Item.leftBubbleText(content: leftBubbleItem))
        }
        self?.inputField.text = ""
        self?.inputField.resignFirstResponder()
    }).disposed(by: disposeBag)
    
    leftPostButtonBubble
      .rx.tap.asDriver()
      .drive(onNext: {
      [weak self] _ in
        if let value = self?.inputField.text {
          let rightBubbleItem = MainViewModel.ContentBubbleItem(text: value, name: "Right")
          self?.viewModel
            .itemPushRelay.accept(MainViewModel.Item.rightBubbleText(content: rightBubbleItem))
        }
        self?.inputField.text = ""
        self?.inputField.resignFirstResponder()
    }).disposed(by: disposeBag)
    
    tableView.rx.modelSelected(MainViewModel.Item.self).asDriver().drive(onNext: {
      v in
      switch v {
      case .leftBubbleText(let content):
        print("right selected value is \(content.text)")
      case .rightBubbleText(let content):
        print("left selected value is \(content.text)")
      }
    }).disposed(by: disposeBag)
    
    viewModel.itemRelay.map { return [MainViewModel.BubbleItemSectionCell.init(items: $0)] }
      .bind(to: tableView.rx.items(dataSource: dataSources))
      .disposed(by: disposeBag)
  }


}

