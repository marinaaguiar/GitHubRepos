//
//  ListViewCell.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import UIKit
import Kingfisher

class ListViewCell: UITableViewCell {

    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    
    func fill(item: Item) {
        username.text = item.owner.username
        repoTitle.text = item.repoTitle
        repoDescription.text = item.repoDescription
        starsCount.text = "\(item.starsCount)"
        forksCount.text = "\(item.forksCount)"
    }
    
    func setupCell() {
        imageBorder()
        backgroundBorder()
        
    }
    
    func imageBorder() {
        authorImageView.layer.borderWidth = 1
        authorImageView.layer.cornerRadius = (authorImageView.frame.size.width / 2)
        authorImageView.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    func backgroundBorder() {
        backgroundCell.layer.borderWidth = 1
        backgroundCell.layer.cornerRadius = 10
        backgroundCell.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00).cgColor
        
        backgroundCell.layer.masksToBounds = false
        backgroundCell.layer.shadowColor = UIColor.gray.cgColor
        backgroundCell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
        backgroundCell.layer.shadowOpacity = 0.2
    }
        
    func updateImage(imageUrl: String?) {
        if let urlString = imageUrl,
            let url = URL(string: urlString) {
            
            authorImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { _ in
                self.setNeedsLayout()
            })
            
        }
    }
}
