//: [Previous](@previous)

import Foundation

// - 5 - Working Wtih Deep JSON Hierarchies
struct Person: Encodable {
    var name: String
    var age: Int
    var residence: Residence

    enum CodingKeys: CodingKey {
        case name, age, residence
    }

    enum ResidenceKeys: CodingKey {
        case numberOfRoom, address
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)

        var residenceContainer = container.nestedContainer(keyedBy: ResidenceKeys.self, forKey: .residence)
        try residenceContainer.encode(residence.numberOfRoom, forKey: .numberOfRoom)
        try residenceContainer.encode(residence.address, forKey: .address)
    }

}

extension Person: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)

        let residenceContainer = try container.nestedContainer(keyedBy: ResidenceKeys.self, forKey: .residence)
        let numberOfRoom = try residenceContainer.decode(Int.self, forKey: .numberOfRoom)
        let address = try residenceContainer.decode(String.self, forKey: .address)
        residence = Residence(numberOfRoom: numberOfRoom, address: address)
    }
}

struct Residence: Codable {
    var numberOfRoom: Int
    var address: String
}

let residence = Residence(numberOfRoom: 101, address: "Tokyo...")
let person = Person(name: "Uruoi", age: 30, residence: residence)

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let data = try encoder.encode(person)
let string = String(data: data, encoding: .utf8)
let samePerson = try decoder.decode(Person.self, from: data)
//: [Next](@next)
