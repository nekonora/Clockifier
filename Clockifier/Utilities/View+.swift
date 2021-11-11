//
//  View+.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 11/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct OnTap: ViewModifier {
    let response: (CGPoint) -> Void
    
    @State private var location: CGPoint = .zero
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                response(location)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { location = $0.location }
            )
    }
}

extension View {
    func onTapGesture(_ handler: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(OnTap(response: handler))
    }
}
