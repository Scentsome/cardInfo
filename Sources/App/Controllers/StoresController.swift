//
//  StoresController.swift
//  App
//
//  Created by cora on 2018/5/14.
//

import Foundation
import Vapor

struct StoresController: RouteCollection {
    // 2
    func boot(router: Router) throws {
        // 3
        let storesRoute = router.grouped("api", "stores")
        // 4
        storesRoute.post(Store.self, use: createHandler)
        // 1
        storesRoute.get(use: getAllHandler)
        // 2
        storesRoute.get(Store.parameter, use: getHandler)
        
        storesRoute.get(Store.parameter, "discount", use: getDiscountsHandler)

    }
    
    // 5
    func createHandler(_ req: Request, store: Store)
        throws -> Future<Store> {
            //6
            return store.save(on: req)
    }
    
    // 1
    func getAllHandler(_ req: Request) throws -> Future<[Store]> {
        // 2
        return Store.query(on: req).all()
    }
    
    // 3
    func getHandler(_ req: Request) throws -> Future<Store> {
        // 4
        return try req.parameters.next(Store.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<Store> {
        return try flatMap(to: Store.self,
                           req.parameters.next(Store.self),
                           req.content.decode(Store.self)) {
                            store, updatedStore in
                            
                            store.name = updatedStore.name
                            
                            return store.save(on: req)
        }
    }
    
    // 1
    func getDiscountsHandler(_ req: Request)
        throws -> Future<[Discount]> {
            // 2
            return try req.parameters.next(Store.self)
                .flatMap(to: [Discount].self) { store in
                    // 3
                    try store.discount.query(on: req).all()
            }
    }
    
}
