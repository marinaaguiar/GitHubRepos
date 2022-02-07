//
//  PullRequestListViewController.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/31/22.
//

import UIKit

class PRListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var listViewCell: ListViewCell?
    private var listViewController: ListViewController?
    
    private var repoResponse: RepoResponse?
    private var pullResquests: [PullResquest] = []
    private var user: User?
    
    var repoTitle: String = ""
    var fullName: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
//        getPR(fullName: fullName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension PRListViewController {
    
    func setupRepoTitle(repoTitle: String) {
        self.repoTitle = repoTitle
        navigationItem.title = repoTitle
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        register()
    }
    
    func register() {
        self.tableView.register(
            .init(nibName: "PRViewCell", bundle: Bundle(for: Self.self)),
            forCellReuseIdentifier: "prCell"
        )
    }
    
//    func getPR(fullName: String) {
//        PRAPI().fetchPRs(fullName: fullName) { [weak self] result in
//            DispatchQueue.main.async {
//
//                guard let self = self else { return }
//
//                self.pullResquests = result
//                self.tableView.reloadData()
//            }
//        }
//    }

}

extension PRListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullResquests.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prCell", for: indexPath) as! PRViewCell
        let index = indexPath.row
        cell.fill(pullResquest: pullResquests[index])
        cell.updateImage(imageUrl: pullResquests[index].user.authorImageUrl)
        cell.setupCell()

        return cell

    }
}

extension PRListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



