//
//  APIController.swift
//  TopTracks App
//
//  Created by Joe Moss on 6/20/16.
//  Copyright © 2016 Iron Yard_Joe Moss. All rights reserved.
//

import UIKit

class APIController: NSObject {
    
    // MARK - Create a session constant
    let session = NSURLSession.sharedSession()
    
    // MARK - Fetch the Related Artists from the Web API
    func fetchRelatedArists(artistID: String) {
        
        // 1. Insert the URLString for the API Call
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/related-artists"
//        print(urlString)
        
        // 2. Attempt to create a valid NSURL from the string
        if let url = NSURL(string: urlString) {
            
            // 3. Create a Data Task for pulling the data from the URL
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                // 4. Check if there is an error
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                // 5. Parse JSON
                if let jsonDictionary = self.parseJSON(data) {
//                    print(jsonDictionary)
                    
                    if let relatedArtistArray = jsonDictionary["artists"] as? JSONArray {
//                        print(relatedArtistArray)
                        
                        for itemDict in relatedArtistArray {
                            
                            let theRelatedArtist = RelatedArtist (dict: itemDict)
                            
                            print(theRelatedArtist.name)
                            print(theRelatedArtist.relatedID)
                            
                            DataStore.sharedInstance.addRelatedArtist(theRelatedArtist)
                            
                        }
                        
                    } else {
                        print("I could not parse the related artists array")
                    }
                    
                } else {
                    print("I could not parse the dictionary")
                }
                
            })
            task.resume()
            
        }
        
    }
    
    // MARK - Fetch the Albums from the Web API
    func fetchAlbums(artistID: String) {
        
        // 1. Insert the URLString for the API Call
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/albums"
//        print(urlString)
        
        // 2. Attempt to create a valid NSURL from the string
        if let url = NSURL(string: urlString) {
            
            // 3. Create a Data Task for pulling the data from the URL
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                // 4. Check if there is an error
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                // 5. Parse JSON
                if let jsonDictionary = self.parseJSON(data) {
//                    print(jsonDictionary)
                    
                    if let itemsArray = jsonDictionary["items"] as? JSONArray {
//                        print(itemsArray)
                        
                        for itemDict in itemsArray {
                            
                            let theAlbum = Album(dict: itemDict)
                            
                            print(theAlbum.name)
                            print(theAlbum.albumID)
                            
                            DataStore.sharedInstance.addAlbum(theAlbum)
                            
                        }
                    } else {
                        print("I could not parse the albums Array")
                    }
                    
                } else {
                    print("I could not parse the dictionary")
                }
                
            })
            task.resume()
            
            
        }
    }

    // MARK - Fetch the Top Tracks from the Web API
    func fetchTopTracks(artistID: String) {
        
        // 1. Insert the URLString for the API Call
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/top-tracks?country=US"
//        print(urlString)
        
        // 2. Attempt to create a valid NSURL from the string
        if let url = NSURL(string: urlString) {
            
            // 3. Create a Data Task for pulling the data from the URL
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                // 4. Check if there is an error
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                // 5. Parse JSON
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

    // MARK - Fetch the Artists from the Web API
    func fetchArtists(query: String) {

        // 1. Insert the URLString for the API Call
        let urlString = "https://api.spotify.com/v1/search?q=\(query)&type=artist"
//        print(urlString)
        
        // 2. Attempt to create a valid NSURL from the string
        if let url = NSURL(string: urlString) {
            
            // 3. Create a Data Task for pulling the data from the URL
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                // 4. Check if there is an error
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                // 5. Parse JSON
                if let jsonDictionary = self.parseJSON(data){
//                    print(jsonDictionary)
                    
                    if let artistsDict = jsonDictionary["artists"] as? JSONDictionary {
                        
                        
                        if let itemsArray = artistsDict["items"] as? JSONArray {
//                            print(itemsArray)
                            
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
    
    // MARK - Send the NSData and retreive a JSONDictionary
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
