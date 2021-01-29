//
//  APIService.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation
import Combine

final class APIService {
    let pageRange = 1...
    let pageSize = 1...100
    var baseURL: URL { URL(string: "https://tle.ivanstanojevic.me/api/tle")! }
    func fetchURL(
        search: String = "",
        sort: SortKey = .name,
        sortDir: SortDirection = .asc,
        page: Int = 1,
        pageSize: Int = 20
    ) -> URL {
        let queryItems = [
            URLQueryItem(name: "search", value: search),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "sort-dir", value: sortDir.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "page-size", value: String(pageSize))
        ]
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
    // TODO: Move into plist or secrets file
    let token = "ItcSCoUu61IBbxoAZt2a083NRqspme99X08QV8Ra"

    func fetchSatellites(
        search: String = "",
        sort: SortKey = .name,
        sortDir: SortDirection = .asc,
        page: Int = 1,
        pageSize: Int = 20
    ) -> AnyPublisher<FetchSatellitesData, TLEAPIError> {
        URLSession.shared.dataTaskPublisher(
            for: fetchURL(search: search, sort: sort, sortDir: sortDir, page: page, pageSize: pageSize)
        )
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw TLEAPIError.url(response)
                }
                guard httpResponse.isSuccessful else {
                    throw TLEAPIError.http(httpResponse)
                }
                return data
            }
            .decode(type: FetchSatellitesData.self, decoder: JSONDecoder())
            .mapError { error in
                guard let apiError = error as? TLEAPIError else {
                    return TLEAPIError.cocoa(error as NSError)
                }
                return apiError
            }
            .eraseToAnyPublisher()
    }

    enum SortKey: String, Decodable {
        case id, name
    }

    enum SortDirection: String, Decodable {
        case asc, desc
    }

    enum TLEAPIError: Error, Equatable {
        case url(URLResponse)
        case http(HTTPURLResponse)
        case parse(TwoLineElementSet.ParseError)
        case cocoa(NSError)
    }

    struct PartialDecodeTLE: Decodable, Equatable {
        let satelliteId: Int
        let name: String
        let date: String
        let line1: String
        let line2: String
    }

    struct FetchSatellitesData: Decodable, Equatable {
        let totalItems: Int
        let parameters: Parameters
        let member: [PartialDecodeTLE]
        let view: [String: String]

        // "parameters":{"search":"*","sort":"name","sort-dir":"asc","page":1,"page-size":20}
        struct Parameters: Decodable, Equatable {
            let search: String
            let sort: SortKey
            let sortDir: SortDirection
            let page: Int
            let pageSize: Int

            enum CodingKeys: String, CodingKey {
                case search
                case sort
                case sortDir = "sort-dir"
                case page
                case pageSize = "page-size"
            }
        }
    }
}

extension TwoLineElementSet {
    init(partialDecode: APIService.PartialDecodeTLE) {
        self.satelliteId = String(partialDecode.satelliteId)
        self.name = partialDecode.name
        self.date = partialDecode.date
        self.line1 = LineOne(raw: partialDecode.line1)
        self.line2 = LineTwo(raw: partialDecode.line2)
    }
}

extension HTTPURLResponse {
    // TODO: Change to collection of RFC 2616/7231 spec codes
    /// Simple range descripting the HTTP success values.
    static let successfulResponseRange = 200..<300

    /// Naive check if the status code is within the success range
    var isSuccessful: Bool { Self.successfulResponseRange.contains(self.statusCode) }
}
