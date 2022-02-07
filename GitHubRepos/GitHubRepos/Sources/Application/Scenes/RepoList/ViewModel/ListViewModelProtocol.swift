//
//  ListViewModelProtocol.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 2/4/22.
//

import Foundation
import UIKit

protocol ListViewModelProtocol: AnyObject {
    
//    func getRepos(page: Int)
    func loadData(query: String)
    var pageCount: Int { get set }
    func errorAlert(title: String, message: String, vc: UIViewController)
    
}

protocol ListViewModelDelegate: AnyObject {
    
    func didLoad()
    func didLoadWithError()
    
}
