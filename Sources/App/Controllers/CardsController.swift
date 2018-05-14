//
//  CardController.swift
//  App
//
//  Created by cora on 2018/5/14.
//

import Foundation
import Vapor

// 1
struct CardsController: RouteCollection {
    // 2
    func boot(router: Router) throws {
        // 3
        let cardsRoute = router.grouped("api", "cards")
        // 4
        cardsRoute.post(Card.self, use: createHandler)
        // 1
        cardsRoute.get(use: getAllHandler)
        // 2
        cardsRoute.get(Card.parameter, use: getHandler)
        
        cardsRoute.get(Card.parameter, "bank", use: getBankHandler)

        cardsRoute.get(Card.parameter, "discount", use: getDiscountsHandler)
        
    }
    
    // 5
    func createHandler(_ req: Request, card: Card)
        throws -> Future<Card> {
            //6
            return card.save(on: req)
    }
    
    // 1
    func getAllHandler(_ req: Request) throws -> Future<[Card]> {
        // 2
        return Card.query(on: req).all()
    }
    
    // 3
    func getHandler(_ req: Request) throws -> Future<Card> {
        // 4
        return try req.parameters.next(Card.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<Card> {
        return try flatMap(to: Card.self,
                           req.parameters.next(Card.self),
                           req.content.decode(Card.self)) {
                            card, updatedCard in
                            
                            card.name = updatedCard.name
                            card.bankID = updatedCard.bankID
                            
                            return card.save(on: req)
        }
    }
    
    func getBankHandler(_ req: Request) throws -> Future<Bank> {
        // 2
        return try req.parameters.next(Card.self)
            .flatMap(to: Bank.self) { card in
                // 3
                try card.bank.get(on: req)
        }
    }
    
    // 1
    func getDiscountsHandler(_ req: Request)
        throws -> Future<[Discount]> {
            // 2
            return try req.parameters.next(Card.self)
                .flatMap(to: [Discount].self) { card in
                    // 3
                    try card.discount.query(on: req).all()
            }
    }
    
    
}
