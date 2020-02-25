//: [Previous](@previous)

import Foundation

// - 7 - Encoding and Decoding Subclasses
class Person: Codable{
    var name: String

    init(name: String) {
        self.name = name
    }
}

class PersonA: Person {
    var birthday: Date
    var residence: Residence

    enum CodingKeys: CodingKey {
        case person, birthday, residence
    }

    init(name: String, birthday: Date, residence: Residence) {
        self.birthday = birthday
        self.residence = residence
        super.init(name: name)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        birthday = try container.decode(Date.self, forKey: .birthday)
        residence = try container.decode(Residence.self, forKey: .residence)

        let baseContainer = try container.superDecoder(forKey: .person)
        try super.init(from: baseContainer)

    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(birthday, forKey: .birthday)
        try container.encode(residence, forKey: .residence)

        let baseEncoder = container.superEncoder(forKey: .person)
        try super.encode(to: baseEncoder)

    }
}

struct Residence: Codable {
    var address: String
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let residence = Residence(address: "Tokyo...")
let personA = PersonA(name: "Uruoi", birthday: Date(), residence: residence)

let data = try encoder.encode(personA)
let string = String(data: data, encoding: .utf8)
let samePerson = try decoder.decode(PersonA.self, from: data)
//: [Next](@next)
