//
//  SatelliteDetailView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI

struct SatelliteDetailView<VStore: ComboViewStore>: View where VStore.State == SatelliteDetailState {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @ObservedObject var viewStore: VStore
    let dismissMaxSize: CGSize

    var body: some View {
        ZStack {
            VStack {
                // Compact size class doesn't have enough room for side-by-side
                if horizontalSizeClass == .regular {
                    HStack {
                        Text(viewStore.state.satellite.name)
                        Text(viewStore.state.satellite.date)
                    }
                    .padding(.top)
                } else {
                    VStack {
                        Text(viewStore.state.satellite.name)
                        Text(viewStore.state.satellite.date)
                    }
                    .padding(.top)
                }
                Spacer()
                Text("Line 1: \(viewStore.state.satellite.line1?.raw ?? "")")
                Text("Line 2: \(viewStore.state.satellite.line2?.raw ?? "")")
            }.foregroundColor(.white)
        }
        VStack {
            Spacer()
            HStack {
                Button(action: {withAnimation( .easeInOut) { viewStore.dispatch(AppAction.detail(.dismiss)) }}) {
                    Image(systemName: "chevron.compact.right")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(maxWidth: dismissMaxSize.width, maxHeight: dismissMaxSize.height)
                }
                Spacer()
            }
            Spacer()
        }
    }
}
