import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
	
	let usersControler = UsersController()
	try router.register(collection: usersControler)
	
	router.get("hello", "iosdevuk") { req in
        return "Hello  iOSDevUK!"
    }
	
	router.get("bottles", Int.parameter) { req  -> Bottles in
		let count = try req.parameters.next(Int.self)
		return Bottles(count: count)
	}
	
	router.get("hello", String.parameter) { req  -> String in
		let name = try req.parameters.next(String.self)
		return "Hello \(name)"
	}
	
	router.post(Bottles.self, at: "bottles") {
		req, bottles -> String in
		return "There were \(bottles.count) bottles"
	}
	
	router.post(Userr.self, at: "user-info") {
		req, user -> String in
		return "Hello \(user.name) you are \(user.age) years old"
	}

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct Bottles: Content {
	let count: Int
}

struct Userr: Content {
	let age: Int
	let name: String
}
