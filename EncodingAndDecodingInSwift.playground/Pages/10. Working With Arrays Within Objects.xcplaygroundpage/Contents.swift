//: [Previous](@previous)

import Foundation

struct Residence: Encodable {
    var address: String
    var label: String
    
    enum CodingKeys: CodingKey {
        case address, label
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address, forKey: .address)
        
        var labelContainer = container.nestedUnkeyedContainer(forKey: .label)
        try labelContainer.encode(label.lowercased())
        try labelContainer.encode(label.uppercased())
        try labelContainer.encode(label)
    }
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let residence = Residence(address: "Tokyo...", label: "Tokyo...")
let data = try encoder.encode(residence)
let string = String(data: data, encoding: .utf8)

extension Residence: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        address = try container.decode(String.self, forKey: .address)
        var labelContainer = try container.nestedUnkeyedContainer(forKey: .label)
        var labelName = ""
        while !labelContainer.isAtEnd {
            labelName = try labelContainer.decode(String.self)
        }
        label = labelName
    }
}

let sameResidence = try decoder.decode(Residence.self, from: data)

//: [Next](@next)
