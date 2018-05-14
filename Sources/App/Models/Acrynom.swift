import Vapor
import FluentPostgreSQL

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    var userID: User.ID
    
    init(short: String, long: String, userID: User.ID) {
        self.short = short
        self.long = long
        self.userID = userID
    }
}

extension Acronym {
    // 1
    var user: Parent<Acronym, User> {
        // 2
        return parent(\.userID)
    }
}


extension Acronym: PostgreSQLModel {}
extension Acronym: Migration {}
extension Acronym: Content {}

extension Acronym: Parameter {}
