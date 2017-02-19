//
//  Song.swift
//  PlaylistUserDefaults
//
//  Created by Nick Reichard on 2/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//


import Foundation

struct Song: Equatable {
    
    
    //Mark: - Properties 
    let title: String
    let artist: String
    
    fileprivate static let titleKey = "title"    // Filepriveate only stays in in this file
    fileprivate static let artistKey = "artist"
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
    
    init?(dictionary: [String: String]) {
        guard let title = dictionary[Song.titleKey],
            let artist = dictionary[Song.artistKey] else { return nil }
        self.init(title: title, artist: artist)
        
    }
    
    var dictionaryRepersentaion: [String: String] {
        return [Song.titleKey: title, Song.artistKey: artist]
    }
    
}

func ==(lhs: Song, rhs: Song) -> Bool {
    return lhs.title == rhs.title && lhs.artist == rhs.artist
}
