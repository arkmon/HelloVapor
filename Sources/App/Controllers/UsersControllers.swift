import Vapor

struct UsersController: RouteCollection {
	func boot(router: Router) throws {
		let usersGroupe = router.grouped("api", "users")
		usersGroupe.post(use: createHandler)
		usersGroupe.get(use: getAllHandlers)
		usersGroupe.get(User.parameter, use: getHandler)
		usersGroupe.delete(User.parameter, use: deleteHandler)
		usersGroupe.put(User.self, at: User.parameter, use: updateHandler)
	}
	
	func createHandler(_ req: Request) throws ->Future<User> {
		return try req.content
			.decode(User.self)
			.flatMap(to: User.self) { user in
				return user.save(on: req)
		}
	}
	
	func getAllHandlers(_ req: Request) throws -> Future <[User]> {
		return User.query(on: req).all()
	}
	
	func getHandler(_ req: Request) throws -> Future <User> {
		return try req.parameters.next(User.self)
	}
	
	func updateHandler(_ req: Request, updatedUser: User) throws -> Future<User> {
			return try req.parameters.next(User.self).flatMap(to:
			User.self) { user in
				user.name = updatedUser.name
				user.userName = updatedUser.userName
				return user.save(on: req)
			}
	}
	
	func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
			let user = try req.parameters.next(User.self)
			return user.delete(on: req).transform(to: .noContent)
	}
}
