//
//  BanksController.swift
//  App
//
//  Created by cora on 2018/5/14.
//

import Foundation
import Vapor

struct BanksController: RouteCollection {
    // 2
    func boot(router: Router) throws {
        // 3
        let banksRoute = router.grouped("api", "banks")
        // 4
        banksRoute.post(Bank.self, use: createHandler)
        // 1
        banksRoute.get(use: getAllHandler)
        // 2
        banksRoute.get(Bank.parameter, use: getHandler)
        
        banksRoute.get(Bank.parameter, "card", use: getCardsHandler)

    }
    
    // 5
    func createHandler(_ req: Request, bank: Bank)
        throws -> Future<Bank> {
            //6
            return bank.save(on: req)
    }
    
    // 1
    func getAllHandler(_ req: Request) throws -> Future<[Bank]> {
        // 2
        return Bank.query(on: req).all()
    }
    
    // 3
    func getHandler(_ req: Request) throws -> Future<Bank> {
        // 4
        return try req.parameters.next(Bank.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<Bank> {
        return try flatMap(to: Bank.self,
                           req.parameters.next(Bank.self),
                           req.content.decode(Bank.self)) {
                            bank, updatedBank in
                            
                            bank.name = updatedBank.name
                            
                            return bank.save(on: req)
        }
    }
    
    func getCardsHandler(_ req: Request)
        throws -> Future<[Card]> {
            // 2
            return try req.parameters.next(Bank.self)
                .flatMap(to: [Card].self) { bank in
                    // 3
                    try bank.card.query(on: req).all()
            }
    }
}
