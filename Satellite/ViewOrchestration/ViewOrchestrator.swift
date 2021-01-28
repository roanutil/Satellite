//
//  ViewOrchestrator.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI
import ComposableArchitecture

struct ViewOrchestrator<Background: View, Earth: View, List: View, Detail: View>: View {
    let store: Store<ViewOrchestratorState, ViewOrchestratorAction>
    let background: Background
    let earth: Earth
    let list: List
    let detail: Detail

    var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { proxy in
                ZStack {
                    background.zIndex(viewStore.backgroundZIndex)
                    earth
                        .scaleEffect(viewStore.earthScale)
                        .frame(
                        width: proxy.width/2,
                        height: proxy.height/2,
                        alignment: .center
                    )
                    .zIndex(viewStore.earthZIndex)
                    list.zIndex(viewStore.listZIndex)
                    detail.zIndex(viewStore.detailZIndex)
                }
            }
        }
    }
}

extension GeometryProxy {
    var width: CGFloat { size.width }
    var height: CGFloat { size.height }
}
