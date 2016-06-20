//
//  ViewController.swift
//  TopTracks App
//
//  Created by Joe Moss on 6/20/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit

class ArtistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let apiController = APIController()
    
    override func viewDidLoad() {
//        self.apiController.fetchArtists("u2")
        self.apiController.fetchTopTracks("3vDpQbGnzRbRVirXlfQagB")

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Test"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    }

}

