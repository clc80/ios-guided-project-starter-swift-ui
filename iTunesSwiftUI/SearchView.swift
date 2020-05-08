//
//  SearchView.swift
//  iTunesSwiftUI
//
//  Created by Claudia Contreras on 5/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import SwiftUI

final class SearchView : NSObject, UIViewRepresentable {
    // Two-way street between two variables
    // Bindidng itself is just a wrapper around 'artistName: String'
    @Binding var artistName: String
    @Binding var artistGenre: String
    
    init(artistNameBinding: Binding<String>, artistGenreBinding: Binding<String>) {
        // In order to assign a binding to our variable
        _artistName = artistNameBinding
        _artistGenre = artistGenreBinding
    }
    
    // Tell the compiler what view we'll be using while being UIViewRepresentable
    // Generics via AssociatedType
    typealias UIViewType = UISearchBar
    
    // Create our UIView
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.delegate = self
        return searchBar
    }
    
    // Update it every single time that SwiftUI updates it.
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.delegate = self
    }
    
}

// IN order to become a UISearchBarDelegate
// 1. Be a class
// 2. Be a final class
// 3. Inherit from NSObject
extension SearchView : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // The user typed _something_ and then pressed return
        //artistName = searchBar.text!
        
        // Fetch the user's input and send it to iTunes
        iTunesAPI.searchArtists(for: searchBar.text!) { (result) in
            
            // When the itunes server responds, we either get an array of artists or an error.
            switch result {
                
            case .success(let artists):
                // If we got an array of artists, make sure there is at least one artist.
                guard let firstArtist = artists.first else { return }
                // Update the string with the name of the first artist that is returned, which triggers its own binding
                self.artistName = firstArtist.artistName
                
                //Update the genre
                self.artistGenre = firstArtist.primaryGenreName
                
            case .failure(let error):
                print(error)
            }
        }
        searchBar.endEditing(true)
    }
    
}
