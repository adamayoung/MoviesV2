//
//  ShowPlotRow.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct ShowPlotRow: View {

    @State private var isShowingFullOverview = false

    var title: String
    var text: String

    init(title: String, text: String) {
        self.title = title
        self.text = text
    }

    #if !os(watchOS)
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(4)

            HStack {
                Spacer()
                Button("Read more", action: readMore)
            }
        }
        .padding(.vertical, 5)
        .sheet(isPresented: $isShowingFullOverview) {
            NavigationView {
                ShowPlotView(title: title, text: text)
            }
        }
    }
    #endif

    #if os(watchOS)
    var body: some View {
        NavigationLink(destination: ShowPlotView(title: title, text: text)) {
            HStack {
                Spacer()
                Text("Plot")
                Spacer()
            }
        }
    }
    #endif

}

extension ShowPlotRow {

    private func readMore() {
        self.isShowingFullOverview = true
    }

}

struct ShowPlotRow_Previews: PreviewProvider {

    static var previews: some View {
        ShowPlotRow(title: "The Old Guard", text: "Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text.")
    }

}
