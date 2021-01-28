//
//  AppEnvironment.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

struct AppEnvironment {
    let mainQueue: DispatchQueue
    let userInitSerialQueue: DispatchQueue
    let apiClient: APIServiceClient

    static let prod = Self(
        mainQueue: .main,
        userInitSerialQueue: .init(label: "userInitSerial", qos: .userInitiated),
        apiClient: APIServiceClient.prod
    )
}
