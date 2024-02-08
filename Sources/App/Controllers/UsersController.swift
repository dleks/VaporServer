//
//  File.swift
//
//
//  Created by Dmitrii Leksashov on 06.02.2024.
//

import Vapor
import JWTKit
import JWT

final class UsersController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let basicMiddleware = [UserAuthenticator()]
        let tokenMiddleware = [SessionToken.authenticator(), SessionToken.guardMiddleware()]
        
        routes
            .grouped(basicMiddleware)
            .get("login", use: login)
        
        routes
            .grouped(tokenMiddleware)
            .get("users", use: users)
    }
    
    func login(req: Request) async throws -> ClientTokenReponse {
        let user = req.auth.get(User.self)
        
        guard let userId = user?.id else { throw Abort(.noContent) }
        
        let payload = SessionToken(userId: userId)
        
        return ClientTokenReponse(token: try req.jwt.sign(payload))
    }
    
    func users(req: Request) async throws -> [User] {
        
        try req.auth.require(SessionToken.self)
        
        return try await User.query(on: req.db).all()
    }
}
