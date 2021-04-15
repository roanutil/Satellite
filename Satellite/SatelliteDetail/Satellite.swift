//
//  Satellite.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

import Foundation

/// I prefer to have a more sensible name throughout the app but no need to duplicate the model from API
typealias Satellite = TwoLineElementSet

/// Convenience access for all properties. Intended for future use when drawing satellites in real time based
/// on actual data.
extension Satellite {
    // MARK: Line 1 Properties
    var number: String? { self.line1?.satelliteNumber }
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
    var revolutionNumber: Int? { self.line2?.revolutionNumber }
}
