//
//  CreateTodoView.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import SwiftUI

struct CreateTodoView: View {
    
    @Environment(\.dismiss) private var dismiss
    let onCreated: () -> Void
    
    @State private var viewModel = TodoFormViewModel(
        service: TodoService()
    )

    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 20) {
                
                TextField("Title", text: $viewModel.title)
                    .frame(maxWidth: .infinity)
                    .frame(width: 350, height: 55)
                    .background(.white)
                    .padding(.horizontal, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 1)
                    )
                
                TextEditor(text: $viewModel.description)
                    .frame(maxWidth: .infinity)
                    .frame(width: 350, height: 250)
                    .background(.white)
                    .padding(.horizontal, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 1)
                    )
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                
                Button {
                    Task {
                        await createTodo()
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Add")
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(width: 200, height: 55)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 25)
                )
                .disabled(viewModel.isLoading)
                
            }
            .navigationTitle("Create Todo")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
    }
    
    private func createTodo() async {
        
        guard !viewModel.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            viewModel.errorMessage = "Title is required"
            return
        }
        
        let todo = await viewModel.createTodo()
        
        if todo != nil {
            
            onCreated()
            
            dismiss()
        }
    }
}


//#Preview {
//    CreateTodoView()
//}
