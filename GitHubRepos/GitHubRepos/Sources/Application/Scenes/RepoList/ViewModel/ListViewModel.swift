//
//  ListViewModel.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 2/4/22.
//

import Foundation
import UIKit

class ListViewModel: ListViewModelProtocol {
    
    private var apiSercice = APIService()
    
    private var repoResponse: RepoResponse?
    
    private var item: Item?
    private var items: [Item] = []
    
    private weak var delegate: ListViewModelDelegate?
    
    var pageCount: Int = 1
    
    init(delegate: ListViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func loadData(query: String) {
        apiSercice.fetchGenericData(endPoint: .urlRequestWith(queryType: .page, query: query)) { [weak self] (result: Result<RepoResponse, NSError>) in
            guard let self = self else { return }
            
            switch result {
            case let .success(data):
                self.repoResponse = data
                debugPrint(self.repoResponse)
                
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
//    func getRepos(page: Int) {
//        RepoAPI().fetchRepos(page: pageCount) { [weak self] result in
//
//            guard let self = self else {
//                self?.delegate?.didLoadWithError()
//                return }
//
//            self.items.append(contentsOf: result.items)
//            self.delegate?.didLoad()
//            return
//        }
//    }
    
    func errorAlert(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
}
