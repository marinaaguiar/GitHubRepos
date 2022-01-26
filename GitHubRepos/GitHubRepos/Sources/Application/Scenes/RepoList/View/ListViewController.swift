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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRepos()
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
        register()
    }
    
    func register() {
        self.tableView.register(
            .init(nibName: "ListViewCell", bundle: Bundle(for: Self.self)),
            forCellReuseIdentifier: "listCell"
        )
    }
    
    func setupNavBar() {
        navigationItem.title = "GitHub Repositories"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
   
    
    func getRepos() {
        RepoAPI().fetchRepos() { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.items = result.items
                self.tableView.reloadData()
                print(result)
            }
        }
    }

}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListViewCell else {
            return UITableViewCell()
        }
                
        let item = indexPath.row
        
        cell.fill(item: items[item])
        cell.updateImage(imageUrl: items[item].owner.authorImageUrl)
        cell.imageBorder()
        
        return cell
    }
    
    private func calculateIndexPathsToReload() -> [IndexPath] {
      let startIndex = items.count - newItems.count
      let endIndex = startIndex + newItems.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

