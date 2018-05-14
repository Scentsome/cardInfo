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
    
    let acronymsController = AcronymsController()
    // 2
    try router.register(collection: acronymsController)
    
    
   
    let usersController = UsersController()
    // 2
    try router.register(collection: usersController)
    
    
    
    
    
    
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
