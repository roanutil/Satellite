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
                do {
                    state.satellites = try response.member.map { try Satellite(partialDecode: $0) }
                } catch {
                    // TODO: Map errors to UI
                    fatalError("Failed to parse two line data to satellites")
                }
                return .none
            default:
                return .none
            }
        }
    }
)
