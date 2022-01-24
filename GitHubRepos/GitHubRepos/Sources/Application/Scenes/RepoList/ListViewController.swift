//
//  ListView.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var items: [Item] = [
        .init(
            repoTitle: "aa",
            owner: [
                .init(
                    username: "AA",
                    authorImageUrl: "AAA"
                )
            ],
            repoDescription: "aaa",
            forksCount: 23,
            starsCount: 42
        )
    ]
//    private weak var delegate: ListViewModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.tableView.register(
            .init(nibName: "ListViewCell", bundle: Bundle(for: Self.self)),
            forCellReuseIdentifier: "listCell"
        )
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListViewCell else {
            return UITableViewCell()
        }
        cell.username.text = "hi"
        cell.forksCount.text = "2"
        return cell

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
//    func cell(_ tableView: UITableView, indexpath: IndexPath, categoryDto: ListCellDTO) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListViewCell.self), for: indexpath) as? ListViewCell else {
//            return ListViewCell()
//        }
//        cell.fill(dto: categoryDto)
//        return cell
//    }
}

extension ListViewController: UITableViewDelegate {
    
//    func transporter(index: Int) -> String {
//        Item[index]
//    }
//    
//    func showItem(item: String) {
//        delegate?.displayItem(item)
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        showItem(item: transporter(index: indexPath.row))
//    }
}
