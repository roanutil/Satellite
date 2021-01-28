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
    var body: some Scene {
        SatelliteScene()
    }

    struct SatelliteScene: Scene {
        let store = Store<AppState, AppAction>(initialState: AppState(viewPhase: .listFocus, list: .init()), reducer: appReducer, environment: AppEnvironment.prod)
        @Environment(\.scenePhase) private var scenePhase

        var body: some Scene {
            WindowGroup {
                AppView(store: store)
                    .onChange(of: scenePhase, perform: { value in
                        switch value {
                        case .active:
                            return
                        default:
                            return
                        }
                    })
            }
        }
    }
}
