//
//  ListSectionHeaderModifier.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import SwiftUI

struct ListSectionHeaderModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(Font.title2.weight(.heavy))
            .foregroundColor(.primary)
            .textCase(.none)
    }

}

extension View {

    func listSectionHeaderStyle() -> some View {
        modifier(ListSectionHeaderModifier())
    }

}
