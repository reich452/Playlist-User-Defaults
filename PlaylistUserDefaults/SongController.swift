//
//  SongController.swift
//  PlaylistUserDefaults
//
//  Created by Nick Reichard on 2/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

class SongController {
    
    static func create(songWithTitle title: String, andArtist artist: String, onPlaylist playlist: Playlist) {
        let song = Song(title: title, artist: artist)
        PlaylistController.shared.add(song: song, toPlaylist: playlist)
        
    }
}



