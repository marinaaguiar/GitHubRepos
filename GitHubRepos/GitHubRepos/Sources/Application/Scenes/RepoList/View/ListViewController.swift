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
//        fill()
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
   
//    func fill() {
//        getAuthorImageUrl(IndexPath)
//    }
    
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
    
//    func getAuthorImageUrl(_ indexPath: IndexPath) {
//
//        if let authorImageUrl = owner?.authorImageUrl,
//           let url = URL(string: authorImageUrl) {
//            self.listViewCell?.authorImageView.kf.setImage(with: url)
//        } else {
//            print("error")
//        }
//    }
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
        cell.repoTitle.text = items[item].repoTitle
        cell.repoDescription.text = items[item].repoDescription
        cell.starsCount.text = String(items[item].starsCount)
        cell.forksCount.text = String(items[indexPath.row].forksCount)
        cell.username.text = items[item].owner.username
//        cell.authorImageView.image = authorImage
        
        cell.imageBorder()
                
        return cell
    }
}

