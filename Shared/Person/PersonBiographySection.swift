//
//  PersonBiographySection.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonBiographySection: View {

    @State private var isShowingFullBiography = false

    var name: String
    var biography: String

    var body: some View {
        #if !os(watchOS)
        Section(header: Text("Bio")) {
            content
        }
        #else
        content
        #endif
    }

    #if !os(watchOS)
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(biography)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(5)

            HStack {
                Spacer()
                Button("Read more", action: readMore)
            }
        }
        .padding(.vertical, 5)
        .sheet(isPresented: $isShowingFullBiography) {
            NavigationView {
                PersonBiographyView(name: name, biography: biography)
            }
        }
    }
    #endif

    #if os(watchOS)
    private var content: some View {
        NavigationLink(destination: PersonBiographyView(name: name, biography: biography)) {
            HStack {
                Spacer()
                Text("Bio")
                Spacer()
            }
        }
    }
    #endif

}

extension PersonBiographySection {

    private func readMore() {
        self.isShowingFullBiography = true
    }

}

struct PersonBiographySection_Previews: PreviewProvider {

    static var previews: some View {
        List {
            PersonBiographySection(name: "Adam Young", biography: "Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text.")
        }
    }

}
