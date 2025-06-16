// Your current (or intended) Holiday.swift
import Foundation

struct Holiday: Identifiable, Decodable {
    var id = UUID() // This is generated, not from JSON
    let date: String
    let localName: String
    let name: String
    let countryCode: String
    let fixed: Bool
    let global: Bool
    let counties: [String]? // This might be missing or null in JSON
    let launchYear: Int?    // This might be missing or null in JSON
    let types: [String]
}
