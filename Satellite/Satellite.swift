//
//  Satellite.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

typealias Satellite = TwoLineElementSet
extension Satellite {
    // MARK: Base Properties
    var id: String { String(self.satelliteId) }

    // MARK: Line 1 Properties
    var number: Int? { self.line1?.satelliteNumber }
    var internationalDesignator: String? { self.line1?.internationalDesignator }
    var epochYearJulianDayFraction: String? { self.line1?.epochYearJulianDayFraction }
    var ballisticCoefficient: Double? { self.line1?.ballisticCoefficient }
    var secondaryBallisticCoefficient: Double? { self.line1?.secondOrderBallisticCoefficient }
    var dragTerm: Double? { self.line1?.dragTerm }
    var checksum: Int? { self.line1?.checkSum }

    // MARK: Line 2 Properties
    var inclination: Double? { self.line2?.inclination }
    var rightAscension: Double? { self.line2?.rightAscension }
    var eccentricity: Double? { self.line2?.eccentricity }
    var argumentOfPerigee: Double? { self.line2?.argumentOfPerigee }
    var meanAnomaly: Double? { self.line2?.meanAnomaly }
    var meanMotion: Double? { self.line2?.meanMotion }
    var revolutionNumber: Double? { self.line2?.revolutionNumber }
}
