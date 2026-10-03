//
//  TodoListViewModel.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class TodoListViewModel {
    
    private let service: TodoServiceProtocol
    
    var todos: [TodoModel] = []
    var isLoading = false
    var errorMessage: String?
    
    init(service: TodoServiceProtocol) {
        self.service = service
    }
    
    func loadTodos() async {
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            
            todos = try await service.fetchTodos()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteTodo(_ todo: TodoModel) async -> Bool {
        do {
            
            
            try await service.deleteTodo(id: todo.id)
            
            todos.removeAll {
                $0.id == todo.id
            }
            
            return true
            
        } catch {
            errorMessage = error.localizedDescription
            
            return false
        }
    }
    
}
