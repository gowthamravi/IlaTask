//
//  CollectionViewDelegate.swift
//  ILATask
//
//  Created by Ravikumar, Gowtham on 14/10/22.
//

import Foundation
import UIKit

protocol ListCollectionViewDelegateInterface: UICollectionViewDelegate, UICollectionViewDataSource {
    var list: [ListViewModel] { get set }
    var totalItems: Int { get set }
}

protocol CollectionListDelegate: AnyObject {
    func reload()
}

class ListCollectionViewDelegate: NSObject, ListCollectionViewDelegateInterface {

    var list: [ListViewModel] = []
    var totalItems: Int = 0

    private weak var delegate: CollectionListDelegate?

    init(delegate: CollectionListDelegate? = nil) {
        self.delegate = delegate
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageViews.image = UIImage(named:list[indexPath.row].imageUrl)
        return cell
    }
}
