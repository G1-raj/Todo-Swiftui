//
//  TodoFormViewModel.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import Foundation

@MainActor
@Observable
final class TodoFormViewModel {
    
    private let service: TodoServiceProtocol
    
    var title = ""
    var description = ""
    var completed = false
    
    var isLoading = false
    var errorMessage: String?
    
    
    init(service: TodoServiceProtocol) {
        self.service = service
    }
    
    func createTodo() async -> TodoModel? {
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            
            let todo = try await service.createTodo(
                title: title,
                description: description
            )
            
            return todo
            
            
            
        } catch {
            errorMessage = error.localizedDescription
            return nil
        }
    }
    
    func updateTodo(id: Int) async -> TodoModel? {
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            
            let todo = try await service.updateTodo(
                id: id,
                title: title,
                description: description,
                completed: completed
            )
            
            return todo
            
        } catch {
            errorMessage = error.localizedDescription
            return nil
        }
    }
}
