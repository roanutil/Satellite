//
//  AppEnvironment.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

struct AppEnvironment {
    let mainQueue: DispatchQueue
    let userInitQueue: DispatchQueue
    let apiClient: APIServiceClient

    static let prod = Self(
        mainQueue: .main,
        userInitQueue: .global(qos: .userInitiated),
        apiClient: APIServiceClient.prod
    )
}
