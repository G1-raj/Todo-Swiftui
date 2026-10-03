//
//  TodoService.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import Foundation

protocol TodoServiceProtocol {
    func fetchTodos() async throws -> [TodoModel]
    
    func fetchTodo(id: Int) async throws -> TodoModel
    
    func createTodo(title: String, description: String) async throws -> TodoModel
    
    func updateTodo(id: Int, title: String, description: String, completed: Bool) async throws -> TodoModel
    
    func deleteTodo(id: Int) async throws
}

final class TodoService: TodoServiceProtocol {
    private let apiClient: ApiClient
    private let baseUrl: URL
    
    init(apiClient: ApiClient = ApiClient(), baseUrl: URL = AppConfig.baseUrl) {
        self.apiClient = apiClient
        self.baseUrl = baseUrl
    }
    
    func fetchTodos() async throws -> [TodoModel] {
        let url = baseUrl.appendingPathComponent("todos")
        
        return try await apiClient.get(
            [TodoModel].self,
            from: url
        )
    }
    
    func fetchTodo(id: Int) async throws -> TodoModel {
        
        let url = baseUrl
            .appendingPathComponent("todos")
            .appendingPathComponent(String(id))
        
        return try await apiClient.get(
            TodoModel.self,
            from: url
        )
    }
    
    func createTodo(title: String, description: String) async throws -> TodoModel {
        let url = baseUrl.appendingPathComponent("todos")
        
        let body = CreateTodoRequestModel(title: title, description: description)
        
        return try await apiClient.post(TodoModel.self, to: url, body: body)
    }
    
    func updateTodo(id: Int, title: String, description: String, completed: Bool) async throws -> TodoModel {
        let url = baseUrl
                    .appendingPathComponent("todos")
                    .appendingPathComponent(String(id))

        let body = UpdateTodoRequestModel(
            title: title,
            description: description,
            completed: completed
        )

        return try await apiClient.put(
            TodoModel.self,
            to: url,
            body: body
        )
    }
    
    func deleteTodo(id: Int) async throws {
       
        let url = baseUrl
                    .appendingPathComponent("todos")
                    .appendingPathComponent(String(id))
        
        

        try await apiClient.delete(from: url)
    }
}
