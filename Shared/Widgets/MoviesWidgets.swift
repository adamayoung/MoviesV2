//
//  MoviesWidgets.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb
import WidgetKit

@main
struct MoviesWidgets: WidgetBundle {

    @WidgetBundleBuilder
    var body: some Widget {
        TrendingTVShowWidget()
        TrendingMovieWidget()
    }

}
