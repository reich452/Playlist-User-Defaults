//
//  PlaylistController.swift
//  PlaylistUserDefaults
//
//  Created by Nick Reichard on 2/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

// Steps 
// 1: Singelton -- Dont use all the time. Eats up memory or global instance
// 2: C-R-U-D 
// 3: Array of playlist

import Foundation

class PlaylistController {
    
    static let shared = PlaylistController()    //Singelton
    var playlists = [Playlist]()
    fileprivate static let playlistKey = "playlists"
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - Create
    
    func create(playlistWithName name: String) {
        let playlist = Playlist(name: name)
        playlists.append(playlist)
        saveToPersistentStore()
        
    }
    
    // MARK: - Read
    
    func loadFromPersistentStore() {
        let userDefaults = UserDefaults.standard  // like a singelton
        guard let playlistDictionaries = userDefaults.object(forKey: PlaylistController.playlistKey) as? [[String: Any]] else { return }
        playlists = playlistDictionaries.flatMap { Playlist(dictionary: $0) }
    }
    
    // MARK: - Update
    
    func add(song: Song, toPlaylist playlist: Playlist) {
        playlist.songs.append(song)
        saveToPersistentStore()
        
    }
    
    // MARK: - Delete 
    
    func delete(playlist: Playlist) {
        guard let index = playlists.index(of: playlist) else { return }
        playlists.remove(at: index)
        saveToPersistentStore()
    }
    
    func remove(song: Song, fromPlaylist playlist: Playlist) {
        guard let index = playlist.songs.index(of: song) else { return }
        playlist.songs.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Saving  -- inverse of loadFromPresistentStore ?? how ??
    
    func saveToPersistentStore() {
        let userDefaults = UserDefaults.standard
        let playlistDictionaries = playlists.map { $0.dictionaryRepresentaion }
        userDefaults.set(playlistDictionaries, forKey: PlaylistController.playlistKey)
        
    }
    
}


