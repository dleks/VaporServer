//
//  File.swift
//  
//
//  Created by Dmitrii Leksashov on 06.02.2024.
//

import Vapor

struct Info: Content {
    var message: String = "use vapor"
    let date: String
    let count: Int
}
