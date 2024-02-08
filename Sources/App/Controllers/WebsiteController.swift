//
//  File.swift
//  
//
//  Created by Dmitrii Leksashov on 07.02.2024.
//

import Vapor

struct WebsiteController: RouteCollection {
   
    func boot(routes: Vapor.RoutesBuilder) throws {
        routes
            .get("leaf", use: leaf)
    }
    
    func leaf(req: Request) async throws -> View {
        return try await req.view.render("index", ["title": "Leaf"])
    }
}
