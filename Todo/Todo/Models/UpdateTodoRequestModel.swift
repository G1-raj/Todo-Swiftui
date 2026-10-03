//
//  UpdateTodoRequestModel.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import Foundation

struct UpdateTodoRequestModel: Encodable {
    let title: String
    let description: String
    let completed: Bool
}
