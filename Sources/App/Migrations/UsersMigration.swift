//
//  File.swift
//  
//
//  Created by Dmitrii Leksashov on 06.02.2024.
//

import Vapor
import Fluent

struct UsersMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .create()
      
        let user = User(username: "user1", password: "1234")

        try await user.save(on: database)
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users")
            .delete()
    }
}
