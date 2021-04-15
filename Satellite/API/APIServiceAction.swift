//
//  APIServiceAction.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import Combine
import ReSwift
import ReSwiftThunk

enum APIServiceAction: Equatable, Action {
    case fetchInProgress(_ cancellable: AnyCancellable)
    case fetchResponse(Result<APIServiceClient.FetchSatellitesData, APIServiceClient.APIError>)

    static func fetch(page: Int) -> Thunk<AppState> {
        return Thunk<AppState> { dispatch, getState in
            guard let state = getState() else { return }
            let apiState = state.list.api

            if apiState.isFetching {
                return
            }

            let cancellable = APIServiceClient.prod.fetchSatellites(page: page, pageSize: apiState.pageSize)
                .mapToResult()
                .receive(on: DispatchQueue.main)
                .sink { dispatch(AppAction.list(.api(.fetchResponse($0)))) }
            dispatch(AppAction.list(.api(.fetchInProgress(cancellable))))
        }
    }
}
