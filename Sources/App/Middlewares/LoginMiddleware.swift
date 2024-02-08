//
//  File.swift
//  
//
//  Created by Dmitrii Leksashov on 06.02.2024.
//

import Foundation
import Vapor

final class LoginMiddleware: AsyncMiddleware {
    func respond(to request: Vapor.Request, chainingTo next: Vapor.AsyncResponder) async throws -> Vapor.Response {
        print("req = \(request)")
        print("next = \(next)")
        return try await next.respond(to: request)
    }
}
