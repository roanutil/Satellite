//
//  SatelliteDetailReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import ComposableArchitecture

let satelliteDetailReducer = Reducer<SatelliteDetailState, SatelliteDetailAction, AppEnvironment> { _, action, _ in
    switch action {
    case .dismiss:
        return .none
    }
}
