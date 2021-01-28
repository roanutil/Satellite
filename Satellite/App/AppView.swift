//
//  AppView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ViewOrchestrator(
                store: orchestratorStore,
                background: Color.black,
                earth: Image("earth"),
                list: SatelliteList(store: listStore),
                detail: IfLetStore(self.detailStore, then: SatelliteDetailView.init)
            ).onAppear(perform: { viewStore.send(.list(.api(.fetch(page: 1)))) })
        }
    }

    var orchestratorStore: Store<ViewOrchestratorState, ViewOrchestratorAction> {
        store.scope(state: { $0.orchestrator }, action: { AppAction.orchestrator($0) })
    }

    var listStore: Store<SatelliteListState, SatelliteListAction> {
        store.scope(state: { $0.list }, action: { AppAction.list($0) })
    }

    var detailStore: Store<SatelliteDetailState?, SatelliteDetailAction> {
        store.scope(state: { $0.detail }, action: { AppAction.detail($0) })
    }
}
