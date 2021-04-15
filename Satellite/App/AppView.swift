//
//  AppView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import ReSwift

struct AppView<VStore: ViewStore & ParentViewStore>: View where VStore.State == AppState, VStore.ParentState == VStore.State {

    @ObservedObject var viewStore: VStore

    var body: some View {
        ViewOrchestrator(
            viewStore: orchestratorViewStore,
            background: BackgroundView.init(containerSize:),
            earth: Earth(),
            list: { maxWidth in SatelliteList(viewStore: listViewStore, maxWidth: maxWidth) },
            detail: { maxDismissSize -> AnyView in
                    if let detailViewStore = self.detailViewStore {
                        return AnyView(SatelliteDetailView(viewStore: detailViewStore, dismissMaxSize: maxDismissSize))
                    } else {
                        return AnyView(EmptyView())
                    }
            }
        )
    }

    var orchestratorViewStore: ChildViewStore<ViewOrchestratorState, VStore> {
        ChildViewStore(parent: viewStore, statePath: \.orchestrator)
    }

    var listViewStore: ChildViewStore<SatelliteListState, VStore> {
        ChildViewStore(parent: viewStore, statePath: \.list)
    }

    var detailViewStore: ChildViewStore<SatelliteDetailState, VStore>? {
        ChildViewStore(parent: viewStore, statePath: \.detail)
    }
}
