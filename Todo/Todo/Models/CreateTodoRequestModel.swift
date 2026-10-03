//
//  CreateTodoRequestModel.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import Foundation

struct CreateTodoRequestModel: Encodable {
    let title: String
    let description: String
}
