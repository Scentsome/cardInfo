//
//  Card.swift
//  App
//
//  Created by cora on 2018/5/14.
//
import Foundation
import Vapor
import FluentPostgreSQL

final class Card: Codable {
    var id: UUID?
    var name: String
    var bankID: Bank.ID
    
    init(name: String, bankID: Bank.ID) {
        self.name = name
        self.bankID = bankID
    }
}

extension Card: PostgreSQLUUIDModel {}
//extension Card: PostgreSQLModel {}
extension Card: Migration {
    
    static func prepare(on connection: PostgreSQLConnection)
        -> Future<Void> {
            
            return Database.create(self, on: connection) { builder in
                
                try addProperties(to: builder)
                
                try builder.addReference(from: \.bankID, to: \Bank.id)
                
            }
    }
}
extension Card: Content {}

extension Card: Parameter {}

extension Card {
    
    var bank: Parent<Card, Bank> {
        
        return parent(\.bankID)
    }
}

extension Card {
    
    var discount: Children<Card, Discount> {
        
        return children(\.cardID)
    }
}

