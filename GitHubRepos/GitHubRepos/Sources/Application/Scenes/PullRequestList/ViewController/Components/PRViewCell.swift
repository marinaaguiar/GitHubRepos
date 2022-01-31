//
//  PullRequestViewCell.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/31/22.
//

import UIKit

class PRViewCell: UITableViewCell {
    
    @IBOutlet weak var prTittle: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var prDescription: UILabel!
    @IBOutlet weak var prDate: UILabel!
    @IBOutlet weak var prAuthorImageView: UIImageView!
    
    func fill(pullResquest: PullResquest) {
        prTittle.text = pullResquest.title
        username.text = pullResquest.user.username
        prDescription.text = pullResquest.body
        prDate.text = pullResquest.dateCreated
    }
    
    func setupCell() {
        imageBorder()
    }
    
    func imageBorder() {
        prAuthorImageView.frame.size.width = 70
        prAuthorImageView.frame.size.height = 70

        prAuthorImageView.layer.borderWidth = 1
        prAuthorImageView.layer.cornerRadius = 35
        prAuthorImageView.layer.borderColor = UIColor.systemGray5.cgColor
    }

    
    func updateImage(imageUrl: String?) {
        if let urlString = imageUrl,
            let url = URL(string: urlString) {
            
            prAuthorImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { _ in
                self.setNeedsLayout()
            })
            
        }
    }

}
