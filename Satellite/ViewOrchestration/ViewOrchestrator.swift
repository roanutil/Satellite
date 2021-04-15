//
//  ViewOrchestrator.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI
import ReSwift

/// Consolidates all or most of the view specific logic for animations, transitions, adaptivity, etc.
struct ViewOrchestrator<VStore: ComboViewStore, Background: View, Earth: View, List: View, Detail: View>: View
where VStore.State == ViewOrchestratorState {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @ObservedObject var viewStore: VStore
    let background: (CGSize) -> Background
    let earth: Earth
    let list: (CGFloat) -> List
    let detail: (CGSize) -> Detail

    var listWidthDivider: CGFloat {
        switch horizontalSizeClass {
        case .regular:
            return 3
        case .compact:
            return 2
        default:
            return 2
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                    background(CGSize(
                        width: proxy.width*viewStore.state.backgroundScale,
                        height: proxy.height*viewStore.state.backgroundScale
                    ))
                    .zIndex(viewStore.state.backgroundZIndex)
                    earth
                        .scaleEffect(viewStore.state.earthScale)
                        .frame(
                            width: proxy.width/2,
                            height: proxy.height/2,
                            alignment: .center
                    )
                        .zIndex(viewStore.state.earthZIndex)
                    VStack {
                        Spacer()
                        HStack {
                            list(proxy.width/listWidthDivider)
                                .padding(.leading)
                            Spacer()
                        }
                        Spacer()
                    }.zIndex(viewStore.state.listZIndex)
                    .offset(x: viewStore.state.shouldOffsetList ? -proxy.width/listWidthDivider : 0, y: 0)

                    detail(CGSize(width: proxy.width/12, height: proxy.height/12)).zIndex(viewStore.state.detailZIndex)
                }
            }.zIndex(1)
            // Cover up the status bar and bottom of screen since I don't want the
            // background to extend out of safe area.
            Color.black
                .ignoresSafeArea(.all, edges: .all)
                .zIndex(0)
        }
    }
}

extension GeometryProxy {
    var width: CGFloat { size.width }
    var height: CGFloat { size.height }
}
