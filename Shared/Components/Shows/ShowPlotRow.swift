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
    var plot: String

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    #if !os(watchOS)
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(plot)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(horizontalSizeClass == .compact ? 5 : nil)

            if horizontalSizeClass == .compact {
                HStack {
                    Spacer()
                    Button("Read more", action: readMore)
                }
            }
        }
        .padding(.vertical, 5)
        .sheet(isPresented: $isShowingFullOverview) {
            NavigationView {
                ShowPlotView(plot: plot)
            }
        }
    }
    #endif

    #if os(watchOS)
    var body: some View {
        NavigationLink(destination: ShowPlotView(plot: plot)) {
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
        ShowPlotRow(title: "The Old Guard", plot: "Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text. Some overview text.")
    }

}
