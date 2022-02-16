//
//  ListViewModelProtocol.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 2/4/22.
//

import Foundation
import UIKit

protocol ListViewModelProtocol: AnyObject {

    var pageCount: Int { get }
    var items: [Item] { get }

    func loadData(query: String)
    func loadMoreData()
    func errorAlert(title: String, message: String, vc: UIViewController)
}

protocol ListViewModelDelegate: AnyObject {
    
    func didLoad()
    func didLoadWithError()
    
}
