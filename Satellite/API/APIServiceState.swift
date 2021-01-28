//
//  APIServiceState.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

struct APIServiceState: Equatable {
    var currentPage: Int = 1
    var pageSize: Int = 20
    var isFetching: Bool = false
}
