//
//  SatelliteDetailView.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import SwiftUI
import ComposableArchitecture

struct SatelliteDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let store: Store<SatelliteDetailState, SatelliteDetailAction>
    let dismissMaxSize: CGSize

    init(store: Store<SatelliteDetailState, SatelliteDetailAction>, dismissMaxSize: CGSize) {
        self.store = store
        self.dismissMaxSize = dismissMaxSize
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                VStack {
                    // Compact size class doesn't have enough room for side-by-side
                    if horizontalSizeClass == .regular {
                        HStack {
                            Text(viewStore.satellite.name)
                            Text(viewStore.satellite.date)
                        }
                        .padding(.top)
                    } else {
                        VStack {
                            Text(viewStore.satellite.name)
                            Text(viewStore.satellite.date)
                        }
                        .padding(.top)
                    }
                    Spacer()
                    Text("Line 1: \(viewStore.satellite.line1?.raw ?? "")")
                    Text("Line 2: \(viewStore.satellite.line2?.raw ?? "")")
                }.foregroundColor(.white)
            }
            VStack {
                Spacer()
                HStack {
                    Button(action: {withAnimation( .easeInOut) { viewStore.send(.dismiss) }}) {
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
}
