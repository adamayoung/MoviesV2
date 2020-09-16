//
//  VoteLabel.swift
//  Movies
//
//  Created by Adam Young on 16/09/2020.
//

import SwiftUI

struct VoteLabel: View {

    var voteAverage: Float

    private var voteColor: Color {
        if voteAverage < 4 {
            return .red
        }

        if voteAverage < 6 {
            return .orange
        }

        if voteAverage < 7.5 {
            return .yellow
        }

        return .green
    }

    var body: some View {
        Label("\(Int(voteAverage * 10))%", systemImage: "rosette")
            .foregroundColor(voteColor)
    }
}

struct VoteLabel_Previews: PreviewProvider {

    static var previews: some View {
        VoteLabel(voteAverage: 6.5)
    }

}
