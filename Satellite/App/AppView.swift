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
        WithViewStore(store) { _ in
            ViewOrchestrator(
                store: orchestratorStore,
                background: BackgroundView.init(containerSize:),
                earth: Earth(),
                list: { maxWidth in SatelliteList(store: listStore, maxWidth: maxWidth) },
                detail: { maxDismissSize in
                    IfLetStore(
                        self.detailStore,
                        then: { SatelliteDetailView(store: $0, dismissMaxSize: maxDismissSize) })
                }
            )
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
