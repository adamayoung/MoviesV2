//
//  PersonDetailsHeader.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonDetailsHeader: View {

    var name: String
    var profileURL: URL?

    private var topPadding: CGFloat {
        #if os(watchOS)
        return 10
        #else
        return 20
        #endif
    }

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                PersonImage(url: profileURL, displaySize: .large)
                    .shadow(radius: 5)
                    .padding(.bottom, 10)

                Group {
                    #if os(watchOS)
                    Text(name)
                        .font(.headline)
                        .fontWeight(.heavy)
                    #else
                    Text(name)
                        .font(.title)
                        .fontWeight(.heavy)
                    #endif
                }
                .multilineTextAlignment(.center)
            }
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 10)
        .padding(.top, topPadding)
        .foregroundColor(.primary)
        .textCase(.none)
    }

}

extension PersonDetailsHeader {

    init(person: Person) {
        self.init(name: person.name, profileURL: person.profileURL)
    }

}

struct PersonDetailsHeader_Previews: PreviewProvider {

    static var previews: some View {
        PersonDetailsHeader(name: "Adam Young", profileURL: URL(string: "https://pbs.twimg.com/profile_images/1275513868664659968/rVhFV8C1_400x400.jpg")!)
    }

}
