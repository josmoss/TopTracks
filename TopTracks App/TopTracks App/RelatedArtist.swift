//
//  RelatedArtist.swift
//  TopTracks App
//
//  Created by Joe Moss on 6/20/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit

class RelatedArtist: NSObject {
    
    var name: String = ""
    var relatedID: String = ""
    
    override init() {
        super.init()
        
        self.name = ""
        self.relatedID = ""
    
    }
    
    init(dict : JSONDictionary) {
        super.init()
        
        if let name = dict["name"] as? String {
            self.name = name
            
        } else {
            print("I could not parse the related artist name")
        }
        
        if let relatedID = dict["id"] as? String {
            self.relatedID = relatedID
            
        } else {
            print("I could not parse the related artist id")
        }
        
    }

}
