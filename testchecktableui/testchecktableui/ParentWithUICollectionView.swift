//
//  ParentWithUICollectionView.swift
//  testchecktableui
//
//  Created by yoseph.savianto on 2020/01/24.
//  Copyright © 2020 yoseph.savianto. All rights reserved.
//

import UIKit

class ParentWithUICollectionView: UIViewController {


    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionFlowLayout: UICollectionViewFlowLayout!
    private var arrayLabels: [String] = ["hehe", "not working", "working now", "uh", "come come come come", "hello world"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionFlowLayout.minimumInteritemSpacing = 8
        collectionFlowLayout.minimumLineSpacing = 8
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.register(CViewCell.self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ParentWithUICollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CViewCell.self, indexPath: indexPath)!
        cell.updateCell()
        cell.labelmain.text = arrayLabels[indexPath.section]

        print("#1 width indexpath section \(indexPath.section) - \(cell.labelmain.bounds.size.width)")
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayLabels.count
    }
    
}
