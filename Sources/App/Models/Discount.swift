//
//  Discount.swift
//  App
//
//  Created by cora on 2018/5/14.
//
import Foundation
import Vapor
import FluentPostgreSQL

final class Discount: Codable {
    var id: UUID?
    var name: String
    var info: String
    var cardID: Card.ID
    var storeID: Store.ID

    init(name: String, info: String, cardID: Card.ID, storeID: Store.ID) {
        self.name = name
        self.info = info
        self.cardID = cardID
        self.storeID = storeID

    }
}

extension Discount: PostgreSQLUUIDModel {}
//extension Discount: PostgreSQLModel {}
extension Discount: Migration {
    
    static func prepare(on connection: PostgreSQLConnection)
        -> Future<Void> {
            
            return Database.create(self, on: connection) { builder in
                
                try addProperties(to: builder)
                
                try builder.addReference(from: \.cardID, to: \Card.id)
                try builder.addReference(from: \.storeID, to: \Store.id)

            }
    }
}
extension Discount: Content {}

extension Discount: Parameter {}

extension Discount {
    
    var card: Parent<Discount, Card> {
        
        return parent(\.cardID)
    }
    
    var store: Parent<Discount, Store> {
        
        return parent(\.storeID)
    }
}

