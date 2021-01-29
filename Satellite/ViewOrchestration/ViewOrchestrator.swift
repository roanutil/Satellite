//
//  ViewOrchestrator.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI
import ComposableArchitecture

struct ViewOrchestrator<Background: View, Earth: View, List: View, Detail: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let store: Store<ViewOrchestratorState, ViewOrchestratorAction>
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
        WithViewStore(store) { viewStore in
            ZStack {
                GeometryReader { proxy in
                    ZStack {
                        background(CGSize(
                            width: proxy.width*viewStore.backgroundScale,
                            height: proxy.height*viewStore.backgroundScale
                        ))
                            .zIndex(viewStore.backgroundZIndex)
                        earth
                            .scaleEffect(viewStore.earthScale)
                            .frame(
                                width: proxy.width/2,
                                height: proxy.height/2,
                                alignment: .center
                        )
                        .zIndex(viewStore.earthZIndex)
                        VStack {
                            Spacer()
                            HStack {
                                list(proxy.width/listWidthDivider)
                                    .padding(.leading)
                                Spacer()
                            }
                            Spacer()
                        }.zIndex(viewStore.listZIndex)
                        .offset(x: viewStore.shouldOffsetList ? -proxy.width/listWidthDivider : 0, y: 0)

                        detail(CGSize(width: proxy.width/12, height: proxy.height/12)).zIndex(viewStore.detailZIndex)
                    }
                }.zIndex(1)
                Color.black
                    .ignoresSafeArea(.all, edges: .all)
                    .zIndex(0)
            }

        }
    }
}

extension GeometryProxy {
    var width: CGFloat { size.width }
    var height: CGFloat { size.height }
}
