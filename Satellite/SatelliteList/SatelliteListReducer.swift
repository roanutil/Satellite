//
//  SatelliteListReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

func satelliteListReducer(action: SatelliteListAction, state: SatelliteListState) -> SatelliteListState {
    var state = state
    switch action {
    case .nextPage:
        break
    case .prevPage:
        break
    case .select:
        break
    case .api(let apiAction):
        switch apiAction {
        case .fetchResponse(.success(let response)):
            state.satellites = response.member.map { Satellite(partialDecode: $0) }
        default:
            break
        }
        state.api = apiServiceReducer(action: apiAction, state: state.api)
    }
    return state
}
