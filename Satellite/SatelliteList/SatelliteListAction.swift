//
//  SatelliteListAction.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import Foundation
import ReSwift
import ReSwiftThunk

enum SatelliteListAction: Equatable, Action {
    case select(_ satellite: Satellite)
    case api(APIServiceAction)

    static func nextPage() -> Thunk<AppState> {
        return Thunk<AppState> { dispatch, getState in
            guard let state = getState() else { return }
            let listState = state.list
            dispatch(APIServiceAction.fetch(page: listState.api.currentPage + 1))
        }
    }

    static func prevPage() -> Thunk<AppState> {
        return Thunk<AppState> { dispatch, getState in
            guard let state = getState() else { return }
            let listState = state.list
            dispatch(APIServiceAction.fetch(page: listState.api.currentPage - 1))
        }
    }
}
