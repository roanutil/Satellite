//
//  SatelliteApp.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import ComposableArchitecture

@main
struct SatelliteApp: App {
    let store: Store<AppState, AppAction>

    init() {
        self.store = Store<AppState, AppAction>(
            initialState: AppState(viewPhase: .listFocus, list: .init()),
            reducer: appReducer,
            environment: AppEnvironment.prod
        )
        let viewStore = ViewStore(self.store)
        // Initialize first fetch from the api on launch
        viewStore.send(AppAction.list(.api(.fetch(page: 1))))
    }
    var body: some Scene {
        SatelliteScene(store: store)
    }

    struct SatelliteScene: Scene {
        let store: Store<AppState, AppAction>
        init(store: Store<AppState, AppAction>) {
            self.store = store
        }

        var body: some Scene {
            WindowGroup {
                AppView(store: store)
            }
        }
    }
}
