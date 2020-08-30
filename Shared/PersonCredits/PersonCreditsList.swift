//
//  PersonCreditsList.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import SwiftUI

struct PersonCreditsList: View {

    var credits: PersonCombinedCredits

    var body: some View {
        #if os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List {
            if !credits.cast.isEmpty {
                Section(header: Text("Actor")) {
                    castSection
                }
            }

            if !credits.crew.isEmpty {
                Section(header: Text("Crew")) {
                    crewSection
                }
            }
        }
    }

    @ViewBuilder private var castSection: some View {
        ForEach(credits.cast, id: \.self) { show in
            switch show {
            case .movie(let movie):
                NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                    MovieRow(movie: movie)
                }

            case .tvShow(let tvShow):
                NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                    TVShowRow(tvShow: tvShow)
                }

            }
        }
    }

    @ViewBuilder private var crewSection: some View {
        ForEach(credits.crew, id: \.self) { show in
            switch show {
            case .movie(let movie):
                NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                    MovieRow(movie: movie)
                }

            case .tvShow(let tvShow):
                NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                    TVShowRow(tvShow: tvShow)
                }

            }
        }
    }

}

struct PersonCreditsList_Previews: PreviewProvider {

    static var previews: some View {
        PersonCreditsList(credits: PersonCombinedCredits(id: 1))
    }

}
