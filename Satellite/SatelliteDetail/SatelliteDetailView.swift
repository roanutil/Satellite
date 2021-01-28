//
//  SatelliteDetailView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import ComposableArchitecture

struct SatelliteDetailView: View {
    let store: Store<SatelliteDetailState, SatelliteDetailAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text(viewStore.satellite.name)
                Text(viewStore.satellite.date)
                Button(action: { withAnimation( .easeInOut) { viewStore.send(.dismiss) }}) {
                    Text("Dismiss")
                }
            }.foregroundColor(.white)
        }
    }
}
