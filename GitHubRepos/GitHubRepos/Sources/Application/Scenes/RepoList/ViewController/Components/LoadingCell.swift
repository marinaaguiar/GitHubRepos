//
//  LoadingCell.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/27/22.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }
}
