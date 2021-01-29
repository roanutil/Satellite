//
//  SatelliteListReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import ComposableArchitecture

let satelliteListReducer = Reducer.combine(
    apiServiceReducer.pullback(
        state: \SatelliteListState.api,
        action: /SatelliteListAction.api,
        environment: { $0 }
    ),
    Reducer <SatelliteListState, SatelliteListAction, AppEnvironment> { state, action, _ in
        switch action {
        case .nextPage:
            return Effect(value: SatelliteListAction.api(.fetch(page: state.api.currentPage + 1)))
        case .prevPage:
            return Effect(value: SatelliteListAction.api(.fetch(page: state.api.currentPage - 1)))
        case .select(let satellite):
            return .none
        case .api(let apiAction):
            switch apiAction {
            case .fetchResponse(.success(let response)):
                state.satellites = response.member.map { Satellite(partialDecode: $0) }
                return .none
            default:
                return .none
            }
        }
    }
)
