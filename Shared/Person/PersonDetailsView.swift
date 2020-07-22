//
//  PersonDetailsView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct PersonDetailsView: View {

    var id: Int

    var body: some View {
        Text("Hello Number \(id)!")
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(id: 5)
    }
}
