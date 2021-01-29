//
//  Earth.swift
//  Satellite
//
//  Created by Andrew Roan on 1/28/21.
//

import SwiftUI

/// View that presents the image of earth with orbitting satellite
struct Earth: View {
    @State private var angle: Double = 0
    var body: some View {
        ZStack(alignment: .center) {
            Image("earth")
                .resizable()
                .scaledToFill()
                .padding()
            VStack {
                HStack {
                    Spacer()
                    Image("satellite")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .blending(color: Color.white)
                        .frame(maxWidth: 10, maxHeight: 10)
                    Spacer()
                }
                Spacer()
            }
            .rotationEffect(.degrees(angle))
            .animation(Animation.linear(duration: 4).repeatForever(autoreverses: false))
        }
        .onAppear(perform: {
            angle = 360
        })
    }
}

struct Earth_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            Color.black
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Earth()
                        .frame(maxWidth: proxy.width/2, maxHeight: proxy.height/2)
                    Spacer()
                }
                Spacer()
            }

        }

    }
}
