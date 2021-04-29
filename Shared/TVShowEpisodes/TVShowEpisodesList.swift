//
//  TVShowEpisodesList.swift
//  Movies
//
//  Created by Adam Young on 11/09/2020.
//

import SwiftUI

struct TVShowEpisodesList: View {

    var episodes: [TVShowEpisode]

    var body: some View {
        List(episodes) { episode in
            TVShowEpisodeRow(episode: episode)
        }
    }
}

// struct TVShowEpisodesList_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowEpisodesList()
//    }
// }
