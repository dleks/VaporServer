//
//  File.swift
//  
//
//  Created by Dmitrii Leksashov on 06.02.2024.
//

import Vapor
import JWTKit

struct SessionToken: Content, Authenticatable, JWTPayload {

    // Constants
    private var expirationTime: TimeInterval = 1 * 15

    // Token Data
    var expiration: ExpirationClaim
    var userId: UUID

    init(userId: UUID) {
        self.userId = userId
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(expirationTime))
    }

    init(user: User) throws {
        self.userId = try user.requireID()
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(expirationTime))
    }

    func verify(using signer: JWTSigner) throws {
        try expiration.verifyNotExpired()
    }
}
