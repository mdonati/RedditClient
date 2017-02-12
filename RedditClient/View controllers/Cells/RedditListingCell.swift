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
    
}
