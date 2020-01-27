//
//  RootPageViewController.swift
//  testchecktableui
//
//  Created by yoseph.savianto on 2020/01/24.
//  Copyright © 2020 yoseph.savianto. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController {

    private var viewControllerWithTableView: ParentWithTableView = {
        let vc = ParentWithTableView.instantiate(ParentWithTableView.self, identifier: String(describing: ParentWithTableView.self), bundle: Bundle.main)!
        return vc
    }()
    private var viewControllerWithCollectionView: ParentWithUICollectionView = {
        let vc = ParentWithUICollectionView.instantiate(ParentWithUICollectionView.self, identifier: String(describing: ParentWithUICollectionView.self), bundle: Bundle.main)!
        return vc
    }()

    private lazy var collectionVC: [UIViewController] = {
        return [self.viewControllerWithTableView, self.viewControllerWithCollectionView]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        setViewControllers([collectionVC.first!], direction: .forward, animated: false, completion: nil)
    }

}

extension RootPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = collectionVC.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        guard nextIndex < collectionVC.count else { return nil }
        return collectionVC[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = collectionVC.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return collectionVC[previousIndex]
    }
}
