//
//  TableViewHeaderCell.swift
//  ILATask
//
//  Created by Ravikumar, Gowtham on 14/10/22.
//

import Foundation
import UIKit


class TableViewHeaderCell: UITableViewHeaderFooterView, UICollectionViewDataSource, UICollectionViewDelegate {


    static let identifier = "TableViewCellHeader"
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()

    let list: [ListViewModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
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
