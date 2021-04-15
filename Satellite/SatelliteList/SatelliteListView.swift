//
//  SatelliteListView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI

struct SatelliteList<VStore: ComboViewStore>: View where VStore.State == SatelliteListState {
    let viewStore: VStore
    let maxWidth: CGFloat

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewStore.state.satellites) { satellite in
                    Button(
                        action: { withAnimation(Animation.easeInOut) {
                            viewStore.dispatch(AppAction.list(.select(satellite)))
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
                Button(action: { viewStore.dispatch(SatelliteListAction.prevPage()) }) {
                    Image(systemName: "chevron.left")
                }
                .disabled(viewStore.state.api.currentPage == 1)
                .padding(.leading)
                Text("\(viewStore.state.api.currentPage)/\(viewStore.state.api.totalPages)")
                Button(action: { viewStore.dispatch(SatelliteListAction.nextPage()) }) {
                    Image(systemName: "chevron.right")
                }
                .disabled(viewStore.state.api.currentPage == viewStore.state.api.totalPages)
                Spacer()
            }.foregroundColor(.white)
        }.frame(maxWidth: maxWidth)
    }
}
