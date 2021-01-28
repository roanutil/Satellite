//
//  SatelliteListView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import ComposableArchitecture

struct SatelliteList: View {
    let store: Store<SatelliteListState, SatelliteListAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                ForEach(viewStore.satellites) { satellite in
                    Button(
                        action: { withAnimation(Animation.easeInOut) {
                                viewStore.send(.select(satellite))
                        }},
                        label: {
                            Text(satellite.name)
                                .background(Color.clear)
                                .foregroundColor(.white)
                        }
                    )
                }
            }.background(Color.clear)
        }
    }
}
