//
//  AppAction.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

enum AppAction: Equatable {
    case list(SatelliteListAction)
    case detail(SatelliteDetailAction)
    case orchestrator(ViewOrchestratorAction)
}
