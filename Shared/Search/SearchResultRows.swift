//
//  SearchResultRows.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct SearchResultRows: View {

    var results: [MultiTypeListItem]

    var body: some View {
        ForEach(results) { result in
            Group {
                switch result {
                case .movie(let movie):
                    NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                        MovieRow(movie: movie)
                    }

                case .tvShow(let tvShow):
                    NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                        TVShowRow(tvShow: tvShow)
                    }

                case .person(let person):
                    NavigationLink(destination: PersonDetailsView(id: person.id)) {
                        PersonRow(person: person)
                    }
                }
            }
        }
    }

}

struct SearchResultRows_Previews: PreviewProvider {

    static var previews: some View {
        SearchResultRows(results: [])
    }

}
