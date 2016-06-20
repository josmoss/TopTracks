//
//  APIController.swift
//  TopTracks App
//
//  Created by Joe Moss on 6/20/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit

class APIController: NSObject {
    
    //create a session constant
    let session = NSURLSession.sharedSession()
    
    // Fetch the Tracks from the Web API
    func fetchTopTracks(artistID: String) {
        // 1. Put URLString from web
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/top-tracks?country=US"
        
        
        // 2. create url
        if let url = NSURL(string: urlString) {
            
            // 3. create a data task for pulling the data from the URL
                let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                    
                    // Check if there is an error
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    // parse the JSON
                    
                    if let jsonDictionary = self.parseJSON(data) {
//                        print(jsonDictionary)
                        if let tracksArray = jsonDictionary["tracks"] as? JSONArray {
//                            print(tracksArray)
                            
                            for tracksDict in tracksArray {
                                
                                let theTrack = Track(dict: tracksDict)
                                
                                print(theTrack.name)
                                print(theTrack.previewURL)
                                
                                DataStore.sharedInstance.addTrack(theTrack)
                                
                            }
                        } else {
                            print("I could not parse the tracks Array")
                        }
                        
                    } else {
                        print("I could not parse the dictionary")
                    }
                    
                })
                task.resume()
                
        }
}

    // Fetch the Artists from the Web API
    func fetchArtists(query: String) {
        
        let urlString = "https://api.spotify.com/v1/search?q=\(query)&type=artist"
        
        print(urlString)
        
        if let url = NSURL(string: urlString) {
            
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                if let jsonDictionary = self.parseJSON(data){
                    print(jsonDictionary)
                    
                    if let artistsDict = jsonDictionary["artists"] as? JSONDictionary {
                        
                        if let itemsArray = artistsDict["items"] as? JSONArray {
                            
                            for itemDict in itemsArray {
                                
                                let theArtist = Artist(dict: itemDict)
                                
                                print(theArtist.name)
                                print(theArtist.artistID)
                                
                                DataStore.sharedInstance.addArtist(theArtist)
                                
                               
                            }
                        }
                    
                    }
                
                } else {
                    
                    print("I could not parse the jsonDictionary")
                }
            
            })
            task.resume()
        
        }
    }
    
    func parseJSON(data: NSData?) -> JSONDictionary? {
        
        var theDictionary : JSONDictionary? = nil
        
        if let data = data {
            do {
                
                if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
                    
                    
                    theDictionary = jsonDictionary
                    
                    //print(jsonDictionary)
                    
                    
                    
                } else {
                    print("Could not parse jsonDictionary")
                }
                
            } catch {
                
            }
            
            
        } else {
            print("Could not unwrap data")
        }
        
        return theDictionary
    }
    


}
