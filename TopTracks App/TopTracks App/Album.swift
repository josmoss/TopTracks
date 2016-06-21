//
//  Album.swift
//  TopTracks App
//
//  Created by Joe Moss on 6/20/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit

class Album: NSObject {
    
    var name: String = ""
    var albumID: String = ""
    
    override init() {
        super.init()
        
        self.name = ""
        self.albumID = ""
        
    }
    
    init(dict : JSONDictionary) {
        super.init()
        
        if let name = dict["name"] as? String {
            self.name = name
            
        } else {
            print("I could not parse the album name")
        }
        
        if let albumID = dict["id"] as? String {
            self.albumID = albumID
            
        } else {
            print("I could not parse the album id")
        }
        
    }
    
}
