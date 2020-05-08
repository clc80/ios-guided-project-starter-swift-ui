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
    }
    
}

// IN order to become a UISearchBarDelegate
// 1. Be a class
// 2. Be a final class
// 3. Inherit from NSObject
extension SearchView : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
