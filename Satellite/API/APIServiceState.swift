//
//  APIServiceState.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import Combine

struct APIServiceState: Equatable {
    var currentPage: Int = 1
    var pageSize: Int = 50
    var totalItemCount: Int = 0
    var totalPages: Int {
        var total = (totalItemCount/pageSize)
        if totalItemCount%pageSize > 0 {
            total += 1
        }
        return total
    }
    var isFetching: Bool = false
    var cancellable: AnyCancellable?
}
