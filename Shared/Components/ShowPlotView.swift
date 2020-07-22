//
//  ShowFullOverview.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct ShowPlotView: View {

    @Environment(\.presentationMode) private var presentationMode

    var title: String
    var text: String

    var body: some View {
        #if os(watchOS)
        content
        #else
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close", action: dismiss)
                }
            }
        #endif
    }

    private var content: some View {
        ScrollView {
            Text(text)
                .padding()
        }
        .navigationTitle("Plot")
    }

}

extension ShowPlotView {

    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }

}

struct ShowPlotView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPlotView(title: "The Old Guard", text: "Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text.")
    }
}
