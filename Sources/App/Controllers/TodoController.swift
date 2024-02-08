import Fluent
import Vapor

struct TodoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: index)
        todos.post("create", use: create)
        todos.post(use: update)
        todos.group(":todoID") { todo in
            todo.delete(use: delete)
        }
    }
    
    func index(req: Request) async throws -> [Todo] {
        try await Todo.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Todo {
        let todo = try req.content.decode(Todo.self)
        try await todo.save(on: req.db)
        return todo
    }
    
    func update(req: Request) async throws -> HTTPStatus {
        let model = try req.content.decode(Todo.self)
        guard let song = try await Todo.find(model.id, on: req.db(.sqlite)) else {
            return .notFound
        }
        song.title = model.title
        try await song.update(on: req.db)
        
        return .ok
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
            return .notFound
        }
        try await todo.delete(on: req.db)
        return .noContent
    }
}
