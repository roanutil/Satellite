//
//  APIServiceClient.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import Combine
import ReSwift

/// Dependency injection point for all services and side effects
struct APIServiceClient: StateType {
    typealias SortKey = APIService.SortKey
    typealias SortDirection = APIService.SortDirection
    typealias FetchSatellitesData = APIService.FetchSatellitesData
    typealias APIError = APIService.TLEAPIError
    private let fetchSatellites: (
        _ search: String,
        _ sort: SortKey,
        _ sortDir: SortDirection,
        _ page: Int,
        _ pageSize: Int
    ) -> AnyPublisher<FetchSatellitesData, APIError>

    func fetchSatellites(page: Int, pageSize: Int) -> AnyPublisher<FetchSatellitesData, APIError> {
        self.fetchSatellites("", .name, .asc, page, pageSize)
    }

    static let prod: Self = {
        let service = APIService()
        return Self(fetchSatellites: service.fetchSatellites)
    }()
}
