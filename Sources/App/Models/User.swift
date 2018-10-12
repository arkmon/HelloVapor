import FluentSQLite
import Vapor

final class User: Codable {
	var id: Int?
	var name: String
	var userName: String
	
	init(name: String, userName: String) {
		self.userName = userName
		self.name = name
	}
}

extension User: SQLiteModel {}
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}
