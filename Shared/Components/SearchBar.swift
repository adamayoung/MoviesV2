//
//  SearchBar.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct SearchBar: View {

    @State private var isEditing = false

    @Binding var text: String

    #if !os(watchOS)
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.leading, 25)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                )
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.secondary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .accessibilityElement(children: .combine)
    }
    #endif

    #if os(watchOS)
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(.leading, 25)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                )
        }
    }
    #endif

}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("some reall fndj fdsjk fghdsjka gfjdksag fjkdsg fjkds fds gfdslkg"))
    }
}
