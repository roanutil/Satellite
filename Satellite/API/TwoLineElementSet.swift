//
//  TwoLineElementSet.swift
//  Satellite
//
//  Created by Andrew Roan on 1/27/21.
//

//https://spaceflight.nasa.gov/realdata/sightings/SSapplications/Post/JavaSSOP/SSOP_Help/tle_def.html

import Foundation

/*
 {
 "@id":"https:\/\/tle.ivanstanojevic.me\/api\/tle\/43638",
 "@type":"TleModel",
 "satelliteId":43638,
 "name":"1998-067PN",
 "date":"2021-01-25T22:18:51+00:00",
 "line1":"1 43638U 98067PN  21025.92976313  .00030751  00000-0  23180-3 0  9997",
 "line2":"2 43638  51.6324 260.5622 0003214 151.1004 209.0172 15.72213394131577"
 }
*/
struct TwoLineElementSet {
    let satelliteId: String
    let name: String
    let date: String
    let line1: LineOne?
    let line2: LineTwo?

    enum ParseError: Error {
        case invalidCountOfElements
        case invalidElement
    }

    // "line1":"1 42849U 17042AA  21026.54510369  .00000579  00000-0  61391-4 0  9990"
    struct LineOne {
        let raw: String
        let satelliteNumber: String?
        let internationalDesignator: String?
        let epochYearJulianDayFraction: String?
        let ballisticCoefficient: Double?
        let secondOrderBallisticCoefficient: Double?
        let dragTerm: Double?
        let checkSum: Int?

        init(raw: String) {
            self.raw = raw
            var parts = raw.split(separator: " ")
            guard parts.count >= 9 else {
                self.satelliteNumber = nil
                self.internationalDesignator = nil
                self.epochYearJulianDayFraction = nil
                self.ballisticCoefficient = nil
                self.secondOrderBallisticCoefficient = nil
                self.dragTerm = nil
                self.checkSum = nil
                return
            }
            parts.remove(at: 0)
            parts.remove(at: 6)
            self.satelliteNumber = String(parts[0])
            self.internationalDesignator = String(parts[1])
            self.epochYearJulianDayFraction = String(parts[2])
            self.ballisticCoefficient = Double(parts[3])
            self.secondOrderBallisticCoefficient = Self.parseLeadingZero(raw: String(parts[4]))
            self.dragTerm = Self.parseLeadingZero(raw: String(parts[5]))
            self.checkSum = Int(parts[6])
        }

        static func parseLeadingZero(raw: String) -> Double? {
            let parts = raw.split(separator: "-")
            guard parts.count == 2,
                  let value = Double(parts[0]),
                  let fractionalPower = Int(parts[1])
            else { return nil }

            return pow(value, -Double(fractionalPower))
        }
    }

    // "line2":"2 42849  97.4954 266.5032 0006639 248.8297 111.2213 14.92619820192684"
    struct LineTwo {
        let raw: String
        let satelliteNumber: String?
        let inclination: Double?
        let rightAscension: Double?
        let eccentricity: Double?
        let argumentOfPerigee: Double?
        let meanAnomaly: Double?
        let meanMotion: Double?
        let revolutionNumber: Int?

        init(raw: String) {
            self.raw = raw
            var parts = raw.split(separator: " ")
            parts.remove(at: 0)
            if parts.count == 7 {
                let part67 = parts[6]
                parts[6] = part67.dropLast(6)
                parts.append(part67.dropFirst(11))
            } else if parts.count < 7 {
                self.satelliteNumber = nil
                self.inclination = nil
                self.rightAscension = nil
                self.eccentricity = nil
                self.argumentOfPerigee = nil
                self.meanAnomaly = nil
                self.meanMotion = nil
                self.revolutionNumber = nil
                return
            }
            self.satelliteNumber = String(parts[0])
            self.inclination = Double(String(parts[1]))
            self.rightAscension = Double(String(parts[2]))
            self.eccentricity = Self.parseLeadingDecimal(raw: String(parts[3]))
            self.argumentOfPerigee = Double(String(parts[4]))
            self.meanAnomaly = Double(String(parts[5]))
            self.meanMotion = Double(parts[6])
            self.revolutionNumber = Int(parts[7])
        }

        static func parseLeadingDecimal(raw: String) -> Double? {
            return Double("0." + raw)
        }
    }
}

extension TwoLineElementSet: Identifiable {
    var id: String { self.satelliteId }
}

extension TwoLineElementSet.LineOne: Hashable {}
extension TwoLineElementSet.LineTwo: Hashable {}
extension TwoLineElementSet: Hashable {}
