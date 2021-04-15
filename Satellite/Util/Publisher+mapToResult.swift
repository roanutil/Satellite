//
//  Publisher+mapToResult.swift
//  Satellite
//
//  Created by Andrew Roan on 4/12/21.
//

import Foundation
import Combine

extension Publisher where Failure: Error {
    func mapToResult() -> Publishers.Catch<Publishers.Map<Self, Result<Self.Output, Self.Failure>>, Just<Result<Self.Output, Self.Failure>>> {
        self.map(Result.success)
              .catch { Just(.failure($0)) }
    }
}
