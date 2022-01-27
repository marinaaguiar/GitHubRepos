//
//  ListView.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var listViewCell: ListViewCell?
        
    private var repoResponse: RepoResponse?
    
    private var item: Item?
    
    private var owner: Owner?

    private var items: [Item] = []
    
    private var pageCount = 0
    
    private var isLoading = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRepos(page: pageCount)
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
    
    func getRepos(page: Int) {
        RepoAPI().fetchRepos(page: pageCount) { [weak self] result in
            DispatchQueue.main.async {
                
                guard let self = self else { return }
                
                self.items.append(contentsOf: result.items)
                self.tableView.reloadData()

            }
        }
    }
    
    func loadMoreData() {
            if !self.isLoading {
                self.isLoading = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.pageCount += 1
                        self.getRepos(page: self.pageCount)
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
            
            let item = indexPath.row
            cell.fill(item: items[item])
            cell.updateImage(imageUrl: items[item].owner.authorImageUrl)
            cell.imageBorder()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingCell
            cell.loadingIndicator.startAnimating()
            return cell
        }
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
                loadMoreData()
            }
        }
}

