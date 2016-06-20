//
//  Artist.swift
//  TopTracks App
//
//  Created by Joe Moss on 6/20/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit

class Artist: NSObject {
    
    var name: String = ""
    var artistID: String = ""
    
    override init() {
        super.init()
        self.name = ""
        self.artistID = ""
    }
    
    init(dict: JSONDictionary) {
        
        super.init()
        
        if let name = dict["name"] as? String {
            self.name = name
            
        } else {
            print("I coun not parse the name")
        }
        
        if let artistID = dict["id"] as? String {
            self.artistID = artistID
            
        } else {
            print("I could not parse the id")
        }

    }

}
