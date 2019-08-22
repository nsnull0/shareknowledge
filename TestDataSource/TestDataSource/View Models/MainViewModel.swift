//
//  MainViewModel.swift
//  TestDataSource
//
//  Created by Yoseph Wijaya on 2019/08/22.
//  Copyright © 2019 curcifer. All rights reserved.
//
import RxSwift
import RxCocoa
import RxDataSources

class MainViewModel {
  struct BubbleItemSectionCell {
    var items: [MainViewModel.Item]
  }
  struct ContentBubbleItem {
    var text: String
    var name: String
  }
  enum Item {
    case rightBubbleText(content: ContentBubbleItem)
    case leftBubbleText(content: ContentBubbleItem)
  }
  private(set) var itemPushRelay: BehaviorRelay<Item?> = BehaviorRelay(value: nil)
  private(set) var itemRelay: BehaviorRelay<[Item]> = BehaviorRelay(value: [])
  private var items:[Item] = []
  private var disposeBag = DisposeBag()
  init() {
    itemPushRelay.asObservable().subscribe(onNext: { [weak self] v in
      guard let self = self else { return }
      if let value = v {
        self.items.append(value)
        self.itemRelay.accept(self.items)
      }
    }).disposed(by: disposeBag)
  }
}

extension MainViewModel.BubbleItemSectionCell: SectionModelType {
  typealias Item = MainViewModel.Item
  init(original: MainViewModel.BubbleItemSectionCell, items: [Item]) {
    self = original
    self.items = items
  }
}
