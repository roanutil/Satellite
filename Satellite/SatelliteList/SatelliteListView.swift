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
    let maxWidth: CGFloat

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                ScrollView {
                    ForEach(viewStore.satellites) { satellite in
                        Button(
                            action: { withAnimation(Animation.easeInOut) {
                                    viewStore.send(.select(satellite))
                            }},
                            label: {
                                HStack {
                                    Text(satellite.name)
                                        .truncationMode(.tail)
                                        .background(Color.clear)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                            }
                        ).padding(.top)
                    }
                }.background(Color.clear)
                HStack {
                    Button(action: { viewStore.send(SatelliteListAction.prevPage) }) {
                        Image(systemName: "chevron.left")
                    }
                    .disabled(viewStore.api.currentPage == 1)
                    .padding(.leading)
                    Text("\(viewStore.api.currentPage)/\(viewStore.api.totalPages)")
                    Button(action: { viewStore.send(SatelliteListAction.nextPage) }) {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(viewStore.api.currentPage == viewStore.api.totalPages)
                    Spacer()
                }.foregroundColor(.white)
            }.frame(maxWidth: maxWidth)
        }
    }
}
