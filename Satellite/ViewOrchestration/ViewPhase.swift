//
//  ViewPhase.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import Foundation

enum ViewPhase: Equatable {
    case listFocus
    case detailFocus(SatelliteDetailState)
}
