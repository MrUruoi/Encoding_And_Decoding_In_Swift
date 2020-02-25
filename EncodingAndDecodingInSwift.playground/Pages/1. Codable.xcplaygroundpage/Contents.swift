// Encoding and Decoding Custom Types
// https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types

import Foundation


// - 1 -
struct Person: Codable {
    var name: String
    var age: Int
    var residence: Residence
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



