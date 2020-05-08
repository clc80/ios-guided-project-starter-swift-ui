//
//  ContentView.swift
//  iTunesSwiftUI
//
//  Created by Fernando Olivares on 28/03/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Struct are value based
// Classes are reference based

// class UILabel -> instance
// struct (var) Text -> modifications -> Text

// Struct that holsa our view
struct ContentView: View {
    @State var artistName: String = ""
    
    var body: some View {
        VStack() {
            
            Text("Search for artists in iTunes")
                .font(.subheadline)
            
            // Textfield is expecting a binding. A binding will help SwiftUI know that it needs to update one of our own custom variables. In order for us to have a custom variable like that, we need to use @state to wrap it.
            //TextField("Search for Artist", text: $artistName)
            
            // We can now do the same thing with our own SearchView
            SearchView()
            
            Text(artistName)
                .font(.largeTitle) // Modify the text ( -> a new text with the modifications)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(3)
            
            HStack() {
                Text("Artist Genre:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Artist Genre placeholder")
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

// Struct that holds our preview.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
