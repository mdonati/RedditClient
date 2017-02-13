//
//  RedditListingCell.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation
import UIKit



class RedditListingCell : UITableViewCell, RedditListingCellProtocol {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var thumbImageView : UIImageView!
    @IBOutlet weak var commentsCountLabel : UILabel!
    
    weak var delegate : RedditListingCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addThumbnailTapGesture()
        self.addThumbnailLongTapGesture()
    }
    
    private func addThumbnailTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(thumbnailTap))
        self.thumbImageView.addGestureRecognizer(tap)
    }
    
    private func addThumbnailLongTapGesture() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(thumbnailLongTap))
        self.thumbImageView.addGestureRecognizer(longTap)
    }
    
    @objc private func thumbnailTap() {
        self.delegate?.redditListingCellDidSelectThumbnail(cell: self)
    }
    
    @objc private func thumbnailLongTap() {
        self.delegate?.redditListingCellDidLongTap(cell: self)
    }
    
}
