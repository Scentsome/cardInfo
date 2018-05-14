import Vapor
import Leaf

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    router.post("api", "acronyms") { req -> Future<Acronym> in
        // 2
        return try req.content.decode(Acronym.self)
            .flatMap(to: Acronym.self) { acronym in
                // 3
                return acronym.save(on: req)
        }
    }
    
    router.get("view") { req -> Future<View> in
        return try req.view().render("welcome")
    }
    
    router.get("weather") { req -> Future<View> in
        return try req.view().render("weather")
    }
    
    router.get("index") { req -> Future<View> in
        return try req.view().render("index")
    }
    
    
//    router.get("api", "acronyms", Acronym.parameter) { req -> Future<Acronym> in
//        // 2
//        return try req.parameters.next(Acronym.self)
//    }
    
        
//    router.put("api", "acronyms", Acronym.parameter) { req -> Future<Acronym> in
//        // 2
//        return try flatMap(to: Acronym.self,
//        req.parameters.next(Acronym.self),
//        req.content.decode(Acronym.self)) {
//        acronym, updatedAcronym in
//        // 3
//        acronym.short = updatedAcronym.short
//        acronym.long = updatedAcronym.long
//
//        // 4
//        return acronym.save(on: req)
//        }
//    }
    
//    router.delete("api", "acronyms", Acronym.parameter) { req -> Future<HTTPStatus> in
//        // 2
//        return try req.parameters.next(Acronym.self)
//        .flatMap(to: HTTPStatus.self) { acronym in
//        // 3
//        return acronym.delete(on: req)
//        .transform(to: HTTPStatus.noContent)
//        }
//    }
    
    let acronymsController = AcronymsController()
    
    try router.register(collection: acronymsController)
    
    let acronymsRoutes = router.grouped("api", "acronyms")

    acronymsRoutes.get(use:acronymsController.getAllHandler )
    
   
    let usersController = UsersController()
    // 2
    try router.register(collection: usersController)
    
    
    
    // 1
    acronymsRoutes.post(Acronym.self, use: acronymsController.createHandler)
    // 2
    acronymsRoutes.get(Acronym.parameter, use: acronymsController.getHandler)
    // 3
    acronymsRoutes.put(Acronym.parameter, use: acronymsController.updateHandler)
    // 4
    acronymsRoutes.delete(Acronym.parameter, use: acronymsController.deleteHandler)
    // 5
    acronymsRoutes.get("search", use: acronymsController.searchHandler)
    // 6
    acronymsRoutes.get("first", use: acronymsController.getFirstHandler)
    // 7
    acronymsRoutes.get("sorted", use: acronymsController.sortedHandler)
    
    /////////Discount
    // 1
    let discountsController = DiscountsController()
    // 2
    try router.register(collection: discountsController)
    
    /////////Card
    // 1
    let cardsController = CardsController()
    // 2
    try router.register(collection: cardsController)

    /////////Store
    // 1
    let storesController = StoresController()
    // 2
    try router.register(collection: storesController)
    
    /////////Bank
    // 1
    let banksController = BanksController()
    // 2
    try router.register(collection: banksController)
    
    
//    router.get("api", "acronyms", use: acronymsController.getAllHandler)

//    router.get("api", "acronyms") { req -> Future<[Acronym]> in
//    // 2
//        return Acronym.query(on: req).all()
//    }
    
//    router.get("api","acronyms",Acronym.parameter) { req -> Future<Acronym> in
//        // 2
//        return try req.parameters.next(Acronym.self)
//    }
//
//    router.put("api","acronyms",
//    Acronym.parameter) { req -> Future<Acronym> in
//        // 2
//        return try flatMap(to: Acronym.self,
//        req.parameters.next(Acronym.self),
//        req.content.decode(Acronym.self)) {
//        acronym, updatedAcronym in
//        // 3
//        acronym.short = updatedAcronym.short
//        acronym.long = updatedAcronym.long
//
//        // 4
//        return acronym.save(on: req)
//        }
//    }
//
//    router.delete("api","acronyms",
//    Acronym.parameter) { req -> Future<HTTPStatus> in
//        // 2
//        return try req.parameters.next(Acronym.self)
//        .flatMap(to: HTTPStatus.self) { acronym in
//        // 3
//        return acronym.delete(on: req)
//        .transform(to: HTTPStatus.noContent)
//        }
//    }
    

}
