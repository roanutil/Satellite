//
//  ViewOrchestratorAction.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import Foundation
import ReSwift

enum ViewOrchestratorAction: Equatable, Action {
    case phaseChangedTo(ViewPhase)
}
