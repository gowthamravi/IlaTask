//
//  ListSearchDelegate.swift
//  ILATask
//
//  Created by Ravikumar, Gowtham on 13/10/22.
//

import Foundation
import UIKit

protocol ListSearchDelegateInterface: UISearchBarDelegate {}

class ListSearchDelegate: NSObject, ListSearchDelegateInterface {

    private weak var delegate: ListSearch?

    init(delegate: ListSearch? = nil) {
        self.delegate = delegate
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        delegate?.searchResult(textSearched: textSearched)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.endEditing()
    }
}

protocol ListSearch: NSObject {
    func searchResult(textSearched: String)
    func endEditing()
}
