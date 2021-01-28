//
//  ViewState.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI

struct ViewOrchestratorState: Equatable {
    // MARK: ZIndex
    var listZIndex: Double
    var detailZIndex: Double
    let earthZIndex: Double = 75
    let backgroundZIndex: Double = 25

    // MARK: Scaling
    var earthScale: CGFloat

    static let listFocus = ViewOrchestratorState(listZIndex: 100, detailZIndex: 0, earthScale: 0.1)

    static let detailFocus = ViewOrchestratorState(listZIndex: 0, detailZIndex: 100, earthScale: 1)
}
