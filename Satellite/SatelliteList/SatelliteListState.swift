//
//  SatelliteListState.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import ReSwift

struct SatelliteListState: StateType, Equatable {
    var satellites: [Satellite] = []
    var api: APIServiceState = .init()
}
