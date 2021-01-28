//
//  APIServiceReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import ComposableArchitecture

let apiServiceReducer = Reducer<APIServiceState, APIServiceAction, AppEnvironment> { state, action, env in
    switch action {
    case let .fetch(page: page):
        return env.apiClient.fetchSatellites(page: page, pageSize: state.pageSize)
            .subscribe(on: env.userInitSerialQueue)
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(APIServiceAction.fetchResponse)
    case .fetchResponse(let result):
        switch result {
        case .success(let data):
            state.isFetching = false
            state.currentPage = data.parameters.page
            return .none
        case .failure:
            // TODO: Map errors to UI
            return .none
        }
    }
}
