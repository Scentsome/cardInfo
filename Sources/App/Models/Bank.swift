//
//  Bank.swift
//  App
//
//  Created by cora on 2018/5/14.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class Bank: Codable {
    var id: UUID?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Bank: PostgreSQLUUIDModel {}
//extension Store: PostgreSQLModel {}
extension Bank: Migration {}
extension Bank: Content {}

extension Bank: Parameter {}

extension Bank {
    // 1
    var card: Children<Bank, Card> {
        // 2
        return children(\.bankID)
    }
}
