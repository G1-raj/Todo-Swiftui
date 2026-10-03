//
//  DetailTodoView.swift
//  Todo
//
//  Created by Govine Rajput on 03/10/26.
//

import SwiftUI

struct DetailTodoView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirmation = false
    
    @State private var viewModel = TodoListViewModel(
        service: TodoService()
    )
    
    @State private var formViewModel = TodoFormViewModel(
        service: TodoService()
    )
    
    let todo: TodoModel
    
    let onTodoChanged: () async -> Void
    
    @State private var isCompleted: Bool
    
    
    init(todo: TodoModel, onTodoChanged: @escaping () async -> Void) {
        self.todo = todo
        self.onTodoChanged = onTodoChanged
        self._isCompleted = State(initialValue: todo.completed)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("TODO")
                        .font(.system( size: 12, weight: .bold ))
                        .tracking(1.5)
                        .foregroundStyle(.secondary)
                        
                    Spacer()
                    
                    StatusBadge( isCompleted: isCompleted )
                }
                
                Text(todo.title)
                .font(.system( size: 32, weight: .bold ))
                    .foregroundStyle(.primary)
                    .fixedSize( horizontal: false, vertical: true )
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Description")
                    .font(.system( size: 15, weight: .semibold ))
                    .foregroundStyle(.secondary)
                
                Text(todo.description)
                    .font(.system( size: 17, weight: .regular ))
                    .foregroundStyle(.primary) .lineSpacing(5)
                    .fixedSize( horizontal: false, vertical: true )
            }
            .frame( maxWidth: .infinity, alignment: .leading )
            .padding(20)
            .background( RoundedRectangle(cornerRadius: 20)
            .fill( Color( UIColor.secondarySystemBackground ) ) )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke( Color.gray.opacity(0.12), lineWidth: 1 )
            )
            .padding(.horizontal, 20)
            .padding(.top, 30)
            
            HStack {
                VStack {
                    Text("Completed")
                        .font(.system(size: 16, weight: .semibold))

                    Text(isCompleted ? "This todo is completed" : "Mark this todo as completed")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Toggle("", isOn: $isCompleted)
                        .labelsHidden()
                        .onChange(of: isCompleted) {_, newValue in
                            Task {
                                await updateTodoStatus(newValue)
                            }
                        }
            }
            .padding(.horizontal, 20)
            .padding(.top, 25)
            
            VStack(spacing: 0) {
                DateRow(
                    icon: "calendar",
                    title: "Created",
                    date: todo.createdAt
                )
                
                Divider()
                .padding(.leading, 52)
                
                DateRow(
                    icon: "arrow.clockwise",
                    title: "Last updated",
                    date: todo.updatedAt
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 25)
            
            Spacer()
            
            HStack(spacing: 16) {
                Button {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                        .font(.system( size: 18, weight: .semibold ))
                    
                    Text("Delete")
                        .font(.system( size: 16, weight: .semibold ))
                }
                .foregroundStyle(.red)
                .frame( maxWidth: .infinity, minHeight: 56 )
                .background(
                    Color.red.opacity(0.08),
                    in: RoundedRectangle(
                        cornerRadius: 16
                    )
                )
                .alert(
                    "Delete Todo?",
                    isPresented: $showDeleteConfirmation
                ) {
                    Button("Delete", role: .destructive) {
                        Task {
                            await deleteTodo()
                        }
                    }
                    
                    Button("Cancel", role: .cancel) {
//                        dismiss()
                    }
                }
                
//                Button {
//                    print("Update todo button pressed")
//                } label: {
//                    Image(systemName: "pencil")
//                        .font(.system( size: 18, weight: .semibold ))
//                    
//                    Text("Edit")
//                        .font(.system( size: 16, weight: .semibold ))
//                }
//                .foregroundStyle(.white)
//                .frame( maxWidth: .infinity, minHeight: 56 )
//                .background( Color.blue, in: RoundedRectangle( cornerRadius: 16 ) )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .top )
        .background( Color( UIColor.systemBackground ) )
        .navigationTitle("Todo Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func deleteTodo() async {
        
         let deleted = await viewModel.deleteTodo(todo)
        
        
        
        if deleted {
            await onTodoChanged()
            dismiss()
        }
        
    }
    
    private func updateTodoStatus(_ completed: Bool) async {
        formViewModel.title = todo.title
        formViewModel.description = todo.description
        formViewModel.completed = completed
        
        let updatedTodo = await formViewModel.updateTodo(id: todo.id)
        
        if updatedTodo == nil {
            isCompleted = !completed
        }
        
        await onTodoChanged()
    }
}

//#Preview {
//    DetailTodoView()
//}
