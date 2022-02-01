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
        prDate.text = dateFormatter(prDate: pullResquest.dateCreated)
    }

    func dateFormatter(prDate: String?) -> String {
        if let inputDate = prDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: inputDate) ?? Date()
            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    func setupCell() {
        imageBorder()
    }
    
    func imageBorder() {
        prAuthorImageView.frame.size.width = 60
        prAuthorImageView.frame.size.height = 60

        prAuthorImageView.layer.borderWidth = 1
        prAuthorImageView.layer.cornerRadius = (prAuthorImageView.frame.size.width / 2)
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
