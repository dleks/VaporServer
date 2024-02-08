//
//  File.swift
//  
//
//  Created by Dmitrii Leksashov on 07.02.2024.
//

import Foundation
import Vapor
import JWTKit

struct UserAuthenticator: AsyncBasicAuthenticator {
    
    func authenticate(basic: Vapor.BasicAuthorization, for request: Vapor.Request) async throws {
        if basic.username == "admin" && basic.password == "12345" {
            request.auth.login(User(id: UUID(), username: "Vapor", password: ""))
        }
    }
}
