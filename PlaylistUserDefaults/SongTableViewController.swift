//
//  SongTableViewController.swift
//  PlaylistUserDefaults
//
//  Created by Nick Reichard on 2/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = playlist?.name
    }
    
    // MARK: - UI Functions 
    
    func createSong() {
        guard let playlist = playlist,
        let songTitle = songTitleTextField.text,
        let artist = artistNameTextField.text,
            !songTitle.isEmpty && !artist.isEmpty else { return }
        SongController.create(songWithTitle: songTitle, andArtist: artist, onPlaylist: playlist)
        songTitleTextField.text = nil
        artistNameTextField.text = nil
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === songTitleTextField {
            artistNameTextField.becomeFirstResponder()
        } else if textField === artistNameTextField {
            createSong()
            resignFirstResponder()
        }
        return true
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playlist?.songs.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        if let song = playlist?.songs[indexPath.row] {
            cell.textLabel?.text = song.title
            cell.detailTextLabel?.text = song.artist
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Songs"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            let song = playlist.songs[indexPath.row]
            PlaylistController.shared.remove(song: song, fromPlaylist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
}
