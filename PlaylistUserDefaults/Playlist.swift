//
//  Playlist.swift
//  PlaylistUserDefaults
//
//  Created by Nick Reichard on 2/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//  
// Good Verson of UserDefaults
// Good dictionary reps and failable inits 





import Foundation


class Playlist: Equatable {
    
    // MARK: - Properties 
    
    let name: String
    var songs: [Song]
    
    fileprivate static let nameKey = "name"
    fileprivate static let songsKey = "songs"
    
    // You put it together - like IKEA
    init(name: String, songs: [Song] = []) {
        self.name = name
        self.songs = songs
    }
    
    
    // Fail able init -- Same format 
    
    convenience init?(dictionary: [String: Any]) {
        guard let name = dictionary[Playlist.nameKey] as? String,
            let songDictionaries = dictionary[Playlist.songsKey] as? [[String: String]] else { return nil }
        let songs = songDictionaries.flatMap { Song(dictionary: $0) }
        self.init(name: name, songs: songs)
        
    }
    
    // Packing it back up and reusing it. Like the fishing tackel box
    
    var dictionaryRepresentaion: [String: Any] {
        let songDictionaries = songs.map { $0.dictionaryRepersentaion }
        return [Playlist.nameKey: name, Playlist.songsKey: songDictionaries]
    }
    
}

func ==(lhs: Playlist, rhs: Playlist) -> Bool {
    return lhs === rhs
} 







// Flat map = Dictionaries - pulls it down a level
// map goes through an array
