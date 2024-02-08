import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("info") { req async throws -> Info in
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        let count = try await Todo.query(on: req.db).all().count
        
        return Info(date: dateString, count: count)
    }
    

    try app.register(collection: TodoController())
    try app.register(collection: UsersController())
    try app.register(collection: WebsiteController())
}
