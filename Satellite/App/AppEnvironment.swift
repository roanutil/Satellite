//
//  AppEnvironment.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import SwiftUI

struct AppEnvironment {
    let mainQueue: DispatchQueue
    let userInitSerialQueue: DispatchQueue
    let apiClient: APIServiceClient
    let stars: [CGPoint]

    static let prod = Self(
        mainQueue: .main,
        userInitSerialQueue: .init(label: "userInitSerial", qos: .userInitiated),
        apiClient: APIServiceClient.prod,
        stars: StarProvider.stars(quantity: 50)
    )
}
