//
//  StarProvider.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI

struct StarProvider {
    static func stars(quantity: Int) -> [CGPoint] {
        (0...quantity).map { _ in
            CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
        }
    }

    static func scaledStars(stars: [CGPoint], frame: CGSize) -> [CGPoint] {
        stars.map { star in
            return CGPoint(x: star.x*frame.width, y: star.y*frame.height)
        }
    }
}

struct StarProviderKey: EnvironmentKey {
    static let defaultValue: [CGPoint] = StarProvider.stars(quantity: 100)
}

extension EnvironmentValues {
    var starProvider: [CGPoint] {
        get {
            return self[StarProviderKey.self]
        }
        set {
            self[StarProviderKey.self] = newValue
        }
    }
}
