//
//  APIServiceStore.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

enum APIServiceAction: Equatable {
    case fetch(page: Int)
    case fetchResponse(Result<APIServiceClient.FetchSatellitesData, APIServiceClient.APIError>)
}
