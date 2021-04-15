//
//  AppReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import ReSwift

func appReducer(action: AppAction, state: AppState) -> AppState {
    var state = state
    switch action {
    case let .detail(detailAction):
        switch detailAction {
        case .dismiss:
            state.viewPhase = .listFocus
        }
    case .list(let listAction):
        switch listAction {
        case .select(let satellite):
            state.viewPhase = .detailFocus(.init(satellite: satellite))
        default:
            break
        }
    case .orchestrator:
        break
    }

    return state
}

func rootReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState(viewPhase: .listFocus, list: SatelliteListState())
    guard let action = action as? AppAction else { return state }
    state = appReducer(action: action, state: state)
    switch action {
    case .detail:
        break
    case .list(let listAction):
        state.list = satelliteListReducer(action: listAction, state: state.list)
    case .orchestrator:
        break
    }
    return state
}
