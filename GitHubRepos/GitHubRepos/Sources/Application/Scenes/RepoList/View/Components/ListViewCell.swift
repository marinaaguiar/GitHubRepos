//
//  ListViewCell.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import UIKit

struct ListCellDTO {
    let username: String
    let repoTitle: String
    let repoDescription: String
    let starsCount: Int
    let forksCount: Int
}

class ListViewCell: UITableViewCell {

    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    
    func fill(dto: ListCellDTO) {
        username.text = dto.username
        repoTitle.text = dto.repoTitle
        repoDescription.text = dto.repoDescription
        starsCount.text = "\(dto.starsCount)"
        forksCount.text = "\(dto.forksCount)"
    }
    
    func imageBorder() {
        authorImageView.layer.borderWidth = 1
        authorImageView.layer.cornerRadius = 35
        authorImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
