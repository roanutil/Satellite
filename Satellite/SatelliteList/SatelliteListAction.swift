//
//  SatelliteListAction.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import Foundation

enum SatelliteListAction: Equatable {
    case nextPage
    case prevPage
    case select(_ satellite: Satellite)
    case api(APIServiceAction)
}
