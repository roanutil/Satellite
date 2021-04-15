//
//  APIServiceReducer.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import ReSwift
import ReSwiftThunk

func apiServiceReducer(action: APIServiceAction, state: APIServiceState) -> APIServiceState {
    var state = state
    switch action {
    case let .fetchResponse(result):
        state.isFetching = false
        state.cancellable = nil
        switch result {
        case .success(let data):
            state.isFetching = false
            state.currentPage = data.parameters.page
            state.totalItemCount = data.totalItems
        case .failure(let error):
            // TODO: Map errors to UI
            print("Network error -- \(error)")
        }
    case let .fetchInProgress(cancellable):
        state.cancellable = cancellable
    }
    return state
}
