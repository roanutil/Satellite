//
//  ViewState.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI
import ReSwift

struct ViewOrchestratorState: StateType, Equatable {
    // MARK: ZIndex
    var listZIndex: Double
    var detailZIndex: Double
    let earthZIndex: Double = 75
    let backgroundZIndex: Double = 25

    // MARK: Scaling
    var earthScale: CGFloat
    var backgroundScale: CGFloat

    // MARK: Offset
    var shouldOffsetList: Bool

    static let listFocus = ViewOrchestratorState(
        listZIndex: 100,
        detailZIndex: 0,
        earthScale: 0.1,
        backgroundScale: 1,
        shouldOffsetList: false
    )

    static let detailFocus = ViewOrchestratorState(
        listZIndex: 100,
        detailZIndex: 100,
        earthScale: 1,
        backgroundScale: 1.1,
        shouldOffsetList: true
    )
}
