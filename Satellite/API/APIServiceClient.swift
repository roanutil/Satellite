//
//  APIServiceClient.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import Combine

struct APIServiceClient {
    typealias SortKey = APIService.SortKey
    typealias SortDirection = APIService.SortDirection
    typealias FetchSatellitesData = APIService.FetchSatellitesData
    typealias APIError = APIService.TLEAPIError
    let fetchSatellites: (_ search: String, _ sort: SortKey, _ sortDir: SortDirection, _ page: Int, _ pageSize: Int) -> AnyPublisher<FetchSatellitesData, APIError>

    static let prod: Self = {
        let service = APIService()
        return Self(fetchSatellites: service.fetchSatellites)
    }()
}
