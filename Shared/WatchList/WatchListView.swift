//
//  WatchListView.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct WatchListView: View {

    var body: some View {
        List {
            Text("Watch List")
        }
        .navigationTitle("Watch List")
    }

}

struct WatchListView_Previews: PreviewProvider {

    static var previews: some View {
        WatchListView()
    }

}
