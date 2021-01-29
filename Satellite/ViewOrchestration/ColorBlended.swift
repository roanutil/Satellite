//
//  ColorBlended.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI

struct ColorBlended: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        ZStack {
            content
            color.blendMode(.sourceAtop)
        }
            .drawingGroup(opaque: false)
    }
}

extension View {
    func blending(color: Color) -> some View {
      modifier(ColorBlended(color: color))
    }
}
