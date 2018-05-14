//
//  DiscountsController.swift
//  App
//
//  Created by cora on 2018/5/14.
//

import Foundation
import Vapor

struct DiscountsController: RouteCollection {
    // 2
    func boot(router: Router) throws {
        // 3
        let discountsRoute = router.grouped("api", "discounts")
        // 4
        discountsRoute.post(Discount.self, use: createHandler)
        // 1
        discountsRoute.get(use: getAllHandler)
        // 2
        discountsRoute.get(Discount.parameter, use: getHandler)
        
        discountsRoute.get(Discount.parameter, "card", use: getCardHandler)
        
        discountsRoute.get(Discount.parameter, "store", use: getStoreHandler)

    }
    
    // 5
    func createHandler(_ req: Request, discount: Discount)
        throws -> Future<Discount> {
            //6
            return discount.save(on: req)
    }
    
    // 1
    func getAllHandler(_ req: Request) throws -> Future<[Discount]> {
        // 2
        return Discount.query(on: req).all()
    }
    
    // 3
    func getHandler(_ req: Request) throws -> Future<Discount> {
        // 4
        return try req.parameters.next(Discount.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<Discount> {
        return try flatMap(to: Discount.self,
                           req.parameters.next(Discount.self),
                           req.content.decode(Discount.self)) {
                            discount, updatedDiscount in
                            
                            discount.name = updatedDiscount.name
                            discount.info = updatedDiscount.info
                            discount.cardID = updatedDiscount.cardID
                            discount.storeID = updatedDiscount.storeID

                            return discount.save(on: req)
        }
    }
    
    // 1
    func getCardHandler(_ req: Request) throws -> Future<Card> {
        // 2
        return try req.parameters.next(Discount.self)
            .flatMap(to: Card.self) { discount in
                // 3
                try discount.card.get(on: req)
        }
    }
    
    func getStoreHandler(_ req: Request) throws -> Future<Store> {
        // 2
        return try req.parameters.next(Discount.self)
            .flatMap(to: Store.self) { discount in
                // 3
                try discount.store.get(on: req)
        }
    }
}
