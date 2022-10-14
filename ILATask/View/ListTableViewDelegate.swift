//
//  ListTableViewDelegate.swift
//  ILATask
//
//  Created by Ravikumar, Gowtham on 13/10/22.
//

import Foundation
import UIKit

protocol ListTableViewDelegateInterface: UITableViewDelegate, UITableViewDataSource {
    var list: [SubListModel] { get set }
    var totalItems: Int { get set }
}

protocol ListDelegate: AnyObject {
    func reload()
}

class ListTableViewDelegate: NSObject, ListTableViewDelegateInterface {

    var list: [SubListModel] = []
    var totalItems: Int = 0

    private weak var delegate: ListDelegate?

    init(delegate: ListDelegate? = nil) {
        self.delegate = delegate
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else {
            return UITableViewCell()
        }
        let listValues = list[indexPath.row]
        cell.configureList(list: listValues)
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderCell.identifier) as! TableViewHeaderCell
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}

