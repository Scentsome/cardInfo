//
//  Store.swift
//  App
//
//  Created by cora on 2018/5/14.
//
import Foundation
import Vapor
import FluentPostgreSQL

final class Store: Codable {
    var id: UUID?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Store: PostgreSQLUUIDModel {}
//extension Store: PostgreSQLModel {}
extension Store: Migration {}
extension Store: Content {}

extension Store: Parameter {}

extension Store {
    // 1
    var discount: Children<Store, Discount> {
        // 2
        return children(\.storeID)
    }
}
