//
//  DataStore.swift
//  TopTracks App
//
//  Created by Joe Moss on 6/20/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit

class DataStore: NSObject {
    
    static let sharedInstance = DataStore()
    override private init() {}
    
    var artistArray = [Artist]()
    var tracksArray = [Track]()
    
    func addArtist(theArtist: Artist) {
        self.artistArray.append(theArtist)
    }
    
    func addTrack(theTrack : Track) {
        self.tracksArray.append(theTrack)
    }
    
}
