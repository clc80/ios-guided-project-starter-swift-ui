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
    
    init(artistNameBinding: Binding<String>) {
        // In order to assign a binding to our variable
        _artistName = artistNameBinding
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
        artistName = searchBar.text!
        
        iTunesAPI.searchArtists(for: artistName) { (result) in
            switch result {
                
            case .success(let artists):
                guard let firstArtist = artists.first else { return }
                // Update the string with the name of the first artist that is returned
                self.artistName = firstArtist.artistName
                
            case .failure(let error):
                print(error)
            }
        }
        searchBar.endEditing(true)
    }
    
}
