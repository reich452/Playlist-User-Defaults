//
//  PlaylistTableViewController.swift
//  PlaylistUserDefaults
//
//  Created by Nick Reichard on 2/2/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var playlistTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UI Functions 
    
    func createPlaylist() {
        guard let playlistName = playlistTextField.text, !playlistName.isEmpty else { return }
        PlaylistController.shared.create(playlistWithName: playlistName)
        playlistTextField.text = nil
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createPlaylist()
        textField.resignFirstResponder()
        return true
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\(playlist.songs.count) songs"

        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.delete(playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }    
    }

    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let destinationViewController = segue.destination as? SongTableViewController else { return }
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        destinationViewController.playlist = playlist 
        
    }
}
