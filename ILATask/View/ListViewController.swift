//
//  ListViewController.swift
//  ILATask
//
//  Created by Ravikumar, Gowtham on 13/10/22.
//

import UIKit

class ListViewController: UIViewController {

    fileprivate lazy var listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.register(TableViewHeaderCell.self, forHeaderFooterViewReuseIdentifier: TableViewHeaderCell.identifier)
        return tableView
    }()

    fileprivate lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barStyle = .default
        searchBar.showsCancelButton = true
        return searchBar
    }()

    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.backgroundColor = .green
        return refresh
    }()

    fileprivate lazy var spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        return spinner
    }()

    var tableViewDelegate: ListTableViewDelegateInterface?
    var searchDelegate: ListSearchDelegateInterface?
    private var presenter: ListPresenterInterface?

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        configureViews()
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getList()
    }

    // MARK: - Configure Views
    private func configureViews() {
        listTableView.tableFooterView = UIView()
        listTableView.delegate = tableViewDelegate
        listTableView.dataSource = tableViewDelegate
        listTableView.tableFooterView = spinner


        view.addSubview(listTableView)

        searchBar.delegate = searchDelegate
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureNavigationBar() {
        navigationItem.title = "Ila Test"
    }

    private func setupDataSource() {
        let repository = ListRepository()
        presenter = ListPresenter(repository: repository)
        presenter?.delegate = self
        presenter?.searchDelegate = self
        tableViewDelegate = ListTableViewDelegate(delegate: self)
        searchDelegate = ListSearchDelegate(delegate: self)
    }
}

extension ListViewController: ListPresenterRequestInterface {

    func succeeded() {
        guard let presenter = presenter else {
            return
        }
        tableViewDelegate?.list = presenter.listModel[0].subListModel
        tableViewDelegate?.totalItems = presenter.totalItems
        listTableView.reloadData()
    }
}

extension ListViewController: ListDelegate {
    func reload() {
        if searchBar.text == "" {
            spinner.startAnimating()
        }
        presenter?.getList()
    }
}

extension ListViewController: ListPresenterSearchInterface {
    func searchResult() {
        guard let presenter = presenter else {
            return
        }
        tableViewDelegate?.list = presenter.filteredList
        tableViewDelegate?.totalItems = presenter.totalItems
        listTableView.reloadData()
    }
}

extension ListViewController: ListSearch {
    func searchResult(textSearched: String) {
        presenter?.getSearchResult(textSearched: textSearched)
    }

    func endEditing() {
        self.view.endEditing(true)
    }
}
