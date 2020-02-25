//: [Previous](@previous)

import Foundation

// - 6 - Encoding and Decoding Dates
// There is no JSON standard for dates, much to the distress of every programmers who's ever worked with them.
// 'JSONEncoder' and 'JSONDecoder' will by default use a double representation of the date's 'timeIntevalSinceReferenceDate', which is not very common in the wild.
struct Person: Codable {
    var name: String
    var birthday: Date
    var residence: Residence
}

struct Residence: Codable {
    var numberOfRoom: Int
    var address: String
}

let residence = Residence(numberOfRoom: 101, address: "Tokyo...")
let person = Person(name: "Uruoi", birthday: Date(), residence: residence)


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

encoder.dateEncodingStrategy = .formatted(.dateFormatter)
decoder.dateDecodingStrategy = .formatted(.dateFormatter)

let data = try encoder.encode(person)
let string = String(data: data, encoding: .utf8)
let samePerson = try decoder.decode(Person.self, from: data)

//: [Next](@next)
