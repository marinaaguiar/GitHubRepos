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
    private var owner: Owner?
    var items: [Item] = []
    private weak var delegate: ListViewModelDelegate?
    var pageCount: Int = 1
    private var isLoading = false
    
    init(delegate: ListViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func loadData(query: String) {
        apiSercice.fetchGenericData(endPoint: .urlRequestWith(queryType: .page, query: query)) { [weak self] (result: Result<RepoResponse, NSError>) in
            guard let self = self else { return }
    
            switch result {
            case let .success(data):
                self.items.append(contentsOf: data.items)
                self.delegate?.didLoad()
                self.isLoading = false
                debugPrint(self.repoResponse)
                
            case let .failure(error):
                self.delegate?.didLoadWithError()
                debugPrint(error)
            }
        }
    }
    
    func loadMoreData() {
        if !isLoading {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.loadData(query: String(self.pageCount))
                self.pageCount += 1
                self.isLoading = false
            }
        }
    }

    
    func errorAlert(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
}
