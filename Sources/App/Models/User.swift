//
//  File.swift
//  
//
//  Created by Dmitrii Leksashov on 06.02.2024.
//

import Vapor
import Fluent

final class User: Model, Content  {
    static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init() { }
    
    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}

extension User: Authenticatable { }




