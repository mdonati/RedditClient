//
//  ViewController.swift
//  RedditClient
//
//  Created by Mariano on 11/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import UIKit

fileprivate enum ListState {
    
    case normal
    case loading
    
}

class RedditListingViewController : UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    fileprivate var lastListingFetched : Listing<Reddit>?
    fileprivate var reddits : [Reddit] = []
    fileprivate var listState : ListState = .normal {
        didSet {
            switch self.listState {
                
            case .normal:
                //Add some insets to the bottom and the top so table view isn't too close to the edges
                self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 20, 0)
                
            case .loading:
                //Add some room for loader
                self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 64, 0)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.load()
    }
    
    private func setupTableView() {
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func load(success : (() -> Void)? = nil, failure : ((_ error : Error) -> Void)? = nil, any : (() -> Void)? = nil) {
        let after = self.lastListingFetched?.after
        self.listState = .loading
        self.fetchReddits(timeLimit: .Day, limit: 25, after: after, count: self.reddits.count, success: { (listing) in
            
            self.reddits.append(contentsOf: listing.children)
            self.tableView.reloadData()
            self.lastListingFetched = listing
            self.listState = .normal
            success?()
            any?()
            
        }) { (error) in
            
            self.listState = .normal
            failure?(error)
            any?()
            
        }
    }
    
    func fetchReddits(timeLimit : TimeLimit, limit : Int, after : String?, count : Int?, success : @escaping (_ listing : Listing<Reddit>) -> Void, failure : @escaping (_ error : Error) -> Void) {
        assertionFailure("To be implemented in child classes")
    }
    
}

extension RedditListingViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reddits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditCell", for: indexPath)
        let redditCell = cell as! RedditListingCellProtocol
        redditCell.updateWithModel(reddit: self.reddits[indexPath.row])
        return cell
    }
    
}

extension RedditListingViewController : UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.hasReachedContentBottom() && self.listState == .normal && self.lastListingFetched?.after != nil {
            //TODO: Initiate activity indicator
            self.load(any: {
                //TODO: Stop activity indicator
            })
        }
    }
    
    private func hasReachedContentBottom() -> Bool {
        let scrollView = self.tableView!
        return scrollView.contentOffset.y + scrollView.bounds.size.height > scrollView.contentSize.height
    }
    
}

