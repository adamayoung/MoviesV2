//
//  DismissKeyboardOnDragModifier.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct DismissKeyboardOnDragModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .gesture(DragGesture().onChanged { _ in
                #if os(iOS)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                #endif
            })
    }

}

extension View {

    func dismissKeyboardOnDrag() -> some View {
        ModifiedContent(content: self, modifier: DismissKeyboardOnDragModifier())
    }

}
