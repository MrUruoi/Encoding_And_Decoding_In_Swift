//: [Previous](@previous)

import Foundation

// - 8 - Handling Arrays With Mixed Types
struct Residence: Codable {
    var address: String
}

let residence = Residence(address: "Tokyo...")

let encoder = JSONEncoder()
let decoder = JSONDecoder()

enum AnyPerson: Encodable {
    case defaultPerson(String)
    case customPerson(String, Int, Residence)
    case noPerson

    enum CodingKeys: CodingKey {
        case name, age, residence
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .defaultPerson(let name):
            try container.encode(name, forKey: .name)
        case .customPerson(let name, let age, let residence):
            try container.encode(name, forKey: .name)
            try container.encode(age, forKey: .age)
            try container.encode(residence, forKey: .residence)
        case .noPerson:
            let context = EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Invalid person!")
            throw EncodingError.invalidValue(self, context)
        }
    }
}

let persons = [AnyPerson.defaultPerson("Uruoi"), AnyPerson.customPerson("Uruoi", 30, residence)]
let data = try encoder.encode(persons)
let string = String(data: data, encoding: .utf8)

extension AnyPerson: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let containerKeys = Set(container.allKeys)
        let defaultKeys = Set<CodingKeys>([.name])
        let customKeys = Set<CodingKeys>([.name, .age, .residence])

        guard containerKeys == defaultKeys || containerKeys == customKeys else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Not enough keys!")
            throw DecodingError.dataCorrupted(context)
        }

        switch containerKeys {
        case defaultKeys:
            let name = try container.decode(String.self, forKey: .name)
            self = .defaultPerson(name)
        case customKeys:
            let name = try container.decode(String.self, forKey: .name)
            let age = try container.decode(Int.self, forKey: .age)
            let residence = try container.decode(Residence.self, forKey: .residence)
            self = .customPerson(name, age, residence)
        default:
            self = .noPerson
        }
    }
}

let samePerson = try decoder.decode([AnyPerson].self, from: data)
//: [Next](@next)
