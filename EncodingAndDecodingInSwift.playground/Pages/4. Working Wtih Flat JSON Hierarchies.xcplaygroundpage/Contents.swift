//: [Previous](@previous)

import Foundation

// - 4 - Working Wtih Flat JSON Hierarchies
struct Person: Encodable {
    var name: String
    var age: Int
    var residence: Residence

    enum CodingKeys: CodingKey {
        case name, age, house
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(residence.address, forKey: .house)
    }
}

extension Person: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        let address = try container.decode(String.self, forKey: .house)
        residence = Residence(address: address)
    }
}

struct Residence: Codable {
    var address: String
}

let residence = Residence(address: "Tokyo...")
let person = Person(name: "Uruoi", age: 30, residence: residence)

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let data = try encoder.encode(person)
let string = String(data: data, encoding: .utf8)
let samePerson = try decoder.decode(Person.self, from: data)
//: [Next](@next)
