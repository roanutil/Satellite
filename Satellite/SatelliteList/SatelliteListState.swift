//
//  SatelliteListState.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

struct SatelliteListState: Equatable {
    var satellites: [Satellite] = []
    var api: APIServiceState = .init()
}
