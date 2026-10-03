//
//  TodoModel.swift
//  Todo
//
//  Created by Govine Rajput on 02/10/26.
//

import Foundation

struct TodoModel: Identifiable, Codable {
    let id: Int
    var title: String
    var description: String
    var completed: Bool
    let createdAt: Date
    let updatedAt: Date
}
