//: [Previous](@previous)

import Foundation

// - 9 - Working With Arrays
struct Residence: Codable {
    var address: String
}

struct Label: Encodable {
    var residence: Residence

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(residence.address.lowercased())
        try container.encode(residence.address.uppercased())
        try container.encode(residence.address)
    }
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let residence = Residence(address: "Tokyo...")

let label = Label(residence: residence)
let data = try encoder.encode(label)
let string = String(data: data, encoding: .utf8)

extension Label: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var address = ""
        while !container.isAtEnd {
            address = try container.decode(String.self)
            //print(address)
        }
        residence = Residence(address: address)
    }
}

let sameLabel = try decoder.decode(Label.self, from: data)
//: [Next](@next)
