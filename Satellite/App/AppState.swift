//
//  AppState.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import Combine
import ComposableArchitecture
import ReSwift

/// Root state
struct AppState: Equatable, StateType {
    var viewPhase: ViewPhase
    var orchestrator: ViewOrchestratorState {
        switch viewPhase {
        case .listFocus:
            return .listFocus
        case .detailFocus:
            return .detailFocus
        }
    }
    var list: SatelliteListState
    var detail: SatelliteDetailState? {
        get {
            if case let .detailFocus(detailState) = self.viewPhase {
                return detailState
            }
            return nil
        }
        set {
            if let state = newValue {
                viewPhase = .detailFocus(state)
            } else {
                viewPhase = .listFocus
            }

        }
    }
}
