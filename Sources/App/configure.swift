import NIOSSL
import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor
import JWTKit

// configures your application
public func configure(_ app: Application) async throws {
    app.jwt.signers.use(.hs256(key: "secret"))
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
   
    app.migrations.add(CreateTodo())
    app.migrations.add(UsersMigration())
    try await app.autoMigrate()
   
    app.views.use(.leaf)
    
    app.webSocket("echo") { req, ws in
        print("req = \(req)")

        ws.onText { socket, text in
            switch text {
            case "exit":
               _ = socket.close()
            case "send":
                socket.send("receive")
            default:
                print("\(text)")
            }
        }
    }
    
    // register routes
    try routes(app)
}
