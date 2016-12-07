//
//  PostCell.swift
//  MyHood
//
//  Created by Patrick Robertson on 5/12/16.
//  Copyright © 2016 Patrick Robertson. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postImage.layer.cornerRadius = 15
        
        
        
    }
    
    func configureCell(_ post: Post) {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.postDescription
        postImage.image = DataService.instance.imageForPath(post.imagePath)
    }

}
