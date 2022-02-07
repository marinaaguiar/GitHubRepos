//
//  ListView.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import UIKit
import Kingfisher
import SwiftUI

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    private lazy var viewModel: ListViewModelProtocol = ListViewModel(delegate: self)
    
    private var listViewCell: ListViewCell?
    
    private var repoResponse: RepoResponse?
    
    private var item: Item?
    
    private var owner: Owner?
    
    private var items: [Item] = []
        
    private var isLoading = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ListViewController {
    
    func setup() {
        setupNavBar()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        register()
    }
    
    func register() {
        self.tableView.register(
            .init(nibName: "ListViewCell", bundle: Bundle(for: Self.self)),
            forCellReuseIdentifier: "listCell"
        )
        self.tableView.register(
            .init(nibName: "LoadingCell", bundle: Bundle(for: Self.self)),
            forCellReuseIdentifier: "loadingcellid"
        )
    }
    
    func setupNavBar() {
        navigationItem.title = "GitHub Repositories"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func loadMoreData() {
        if !isLoading {
            isLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.viewModel.loadData(query: String(self.viewModel.pageCount))
                self.viewModel.pageCount += 1
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        } else if section == 1 {
            //Return the Loading cell
            return 1
        } else {
            //Return nothing
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
            let index = indexPath.row
            cell.fill(item: items[index])
            cell.updateImage(imageUrl: items[index].owner.authorImageUrl)
            cell.setupCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingCell
            cell.loadingIndicator.startAnimating()
            return cell
        }
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        guard let repoTitle = items[indexPath.row].repoTitle else {
            return
        }
        
        guard let fullName = items[indexPath.row].fullName else {
            return
        }
        displayPullRequests(repoTitle, fullName)
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ListViewCell {
            cell.backgroundCell.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
            cell.backgroundCell.layer.shadowOpacity = 0.4
            cell.contentView.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ListViewCell {
            cell.backgroundCell.backgroundColor = nil
            cell.backgroundCell.layer.shadowOpacity = 0.2
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func isScrollViewAtEnd() -> Bool {
        
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        
        if offsetY > contentHeight - tableView.frame.size.height {
            return true
        } else {
            return false
        }
    }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if isScrollViewAtEnd() {
                loadMoreData()
            }
        }
}


extension ListViewController {
    
    func displayPullRequests(_ repoTitle: String, _ fullName: String) {
        let prViewController = PRListViewController()
        
        prViewController.setupRepoTitle(repoTitle: repoTitle)
//        prViewController.getPR(fullName: fullName)
        navigationController?.pushViewController(prViewController, animated: true)
    }
}

extension ListViewController: ListViewModelDelegate {
    
    func didLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func didLoadWithError() {
        viewModel.errorAlert(title: "Current Data Not Available", message: "Try again later", vc: self)
    }
}
