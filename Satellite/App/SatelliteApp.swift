//
//  SatelliteApp.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import ReSwift
import ReSwiftThunk

@main
struct SatelliteApp: App {
    let store: ReSwift.Store<AppState>

    init() {
        let thunkMiddleware: Middleware<AppState> = createThunkMiddleware()
        self.store = Store(reducer: rootReducer, state: nil, middleware: [thunkMiddleware])
    }
    var body: some Scene {
        SatelliteScene(store: store)
    }

    struct SatelliteScene: Scene {
        let store: ReSwift.Store<AppState>
        let viewStore: RootViewStore<AppState>
        init(store: ReSwift.Store<AppState>) {
            self.store = store
            let viewStore = RootViewStore(store)
            self.viewStore = viewStore
            viewStore.dispatch(APIServiceAction.fetch(page: 1))
        }

        var body: some Scene {
            WindowGroup {
                AppView(viewStore: viewStore)
            }
        }
    }
}
