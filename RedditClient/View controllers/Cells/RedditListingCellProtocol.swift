//
//  RedditListingCellProtocol.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation
import UIKit

protocol RedditListingCellProtocol {
    
    weak var titleLabel : UILabel! { get }
    weak var authorLabel : UILabel! { get }
    weak var dateLabel : UILabel! { get }
    weak var commentsCountLabel : UILabel! { get }
    weak var thumbImageView : UIImageView! { get }
    
}

extension RedditListingCellProtocol {
    
    func updateWithModel(reddit : RedditProtocol) {
        self.titleLabel.text = reddit.title
        self.authorLabel.text = reddit.author
        self.commentsCountLabel.text = "\(reddit.commentsCount) comments"
    }
    
}
