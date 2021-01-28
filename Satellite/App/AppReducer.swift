//
//  AppReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    satelliteListReducer.pullback(
        state: \AppState.list,
        action: /AppAction.list,
        environment: { $0 }
    ),
    satelliteDetailReducer.optional().pullback(
        state: \AppState.detail,
        action: /AppAction.detail,
        environment: { $0 }
    ),
    Reducer { state, action, _ in
        switch action {
        case .detail(let detailAction):
            switch detailAction {
            case .dismiss:
                state.viewPhase = .listFocus
                return .none
            }
        case .list(let listAction):
            switch listAction {
            case .select(let satellite):
                state.viewPhase = .detailFocus(.init(satellite: satellite))
                return .none
            default:
                return .none
            }
        case .orchestrator(let orchestratorAction):
            return .none
        }
    }
)
