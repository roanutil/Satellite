//
//  AppAction.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import ReSwift

enum AppAction: Equatable, Action {
    case list(SatelliteListAction)
    case detail(SatelliteDetailAction)
    case orchestrator(ViewOrchestratorAction)
}
