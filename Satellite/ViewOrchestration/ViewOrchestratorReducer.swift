//
//  ViewOrchestratorReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import ComposableArchitecture

let orchestratorReducer = Reducer<ViewOrchestratorState, ViewOrchestratorAction, AppEnvironment> { _, action, _ in
    switch action {
    case .phaseChangedTo:
        return .none
    }
}
