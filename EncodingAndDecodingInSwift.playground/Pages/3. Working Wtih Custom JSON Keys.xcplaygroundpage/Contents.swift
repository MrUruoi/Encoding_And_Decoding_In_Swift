//: [Previous](@previous)

import Foundation

// - 3 - Working Wtih Custom JSON Keys
struct Person: Codable {
    var name: String
    var age: Int
    var residence: Residence

    enum CodingKeys: String, CodingKey {
        case name, age, residence = "house"
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
