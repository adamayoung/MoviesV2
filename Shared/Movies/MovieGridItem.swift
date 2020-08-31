//
//  MovieGridItem.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct MovieGridItem: View {

    var movie: MovieListItem

    var body: some View {
        PosterImage(url: movie.posterURL)
    }

}

//struct MovieGridItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieGridItem()
//    }
//}
