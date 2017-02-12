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
        
        //Title
        self.titleLabel.text = reddit.title
        
        //Author
        self.authorLabel.text = reddit.author
        
        //12 hours ago, appends by for the author
        self.dateLabel.text = "\(reddit.date.timeAgo()) by"
        
        //Author's username
        self.commentsCountLabel.text = "\(reddit.commentsCount.decimalNumberString) comments"
        
        //Thumb image
        if let thumbURL = reddit.thumbnailImageURL {
            AppRoot.imageManager.getImage(url: thumbURL, completion: { (image, url) in
                //Avoid setting the image into a cell's model that didn't request it
                if thumbURL.absoluteString != url.absoluteString {
                    return
                }
                self.thumbImageView.image = image
            })
        }
        
    }
    
}
