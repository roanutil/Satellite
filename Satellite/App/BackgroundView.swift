//
//  BackgroundView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI

// The black background with stars generated over it that covers of the of the screen
struct BackgroundView: View {
    @Environment(\.starProvider) var stars
    let containerSize: CGSize

    init(containerSize: CGSize) {
        self.containerSize = containerSize
    }

    var body: some View {
        ZStack {
            Color.black
                .zIndex(10)
            ForEach(stars, id: \.self) { star in
                Circle()
                    .fill(Color.white)
                    .frame(width: 2, height: 2, alignment: .center)
                    // Scale star positions with size of background.
                    .position(CGPoint(x: star.x*containerSize.width, y: star.y*containerSize.height))
                    .zIndex(20)

            }
        }
    }
}

extension CGPoint: Hashable {
    static func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(containerSize: .init(width: 100, height: 100))
    }
}
