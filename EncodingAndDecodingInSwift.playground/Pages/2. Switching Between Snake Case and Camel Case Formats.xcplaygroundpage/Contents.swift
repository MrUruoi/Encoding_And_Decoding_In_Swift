//: [Previous](@previous)
import Foundation

//// - 2 - Switching Between Snake Case and Camel Case Formats
//struct Person: Codable {
//    var name: String
//    var age: Int
//    var residence: Residence
//}
//
//struct Residence: Codable {
//    var numberOfRoom: Int
//    var address: String
//}
//
//let residence = Residence(numberOfRoom: 101, address: "Tokyo...")
//let person = Person(name: "Uruoi", age: 30, residence: residence)
//
//let encoder = JSONEncoder()
//encoder.keyEncodingStrategy = .convertToSnakeCase
//let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//let data = try encoder.encode(person)
//let string = String(data: data, encoding: .utf8)
//let samePerson = try decoder.decode(Person.self, from: data)
//: [Next](@next)
