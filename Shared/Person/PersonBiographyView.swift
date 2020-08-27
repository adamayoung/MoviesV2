//
//  PersonBiographyView.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonBiographyView: View {

    @Environment(\.presentationMode) private var presentationMode

    var name: String
    var biography: String

    var body: some View {
        #if os(watchOS)
        return content
        #elseif os(iOS)
        return content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Close", action: dismiss)
                }
            }
        #else
        return content
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Close", action: dismiss)
                }
            }
        #endif
    }

    private var content: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(biography)
                HStack {
                    Spacer()
                }
            }
            .multilineTextAlignment(.leading)
            .padding()
        }
        .navigationTitle(name)
    }

}

extension PersonBiographyView {

    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }

}

struct PersonBiographyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonBiographyView(name: "Adam Young", biography: "Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text. Some biography text.")
        }
    }
}
