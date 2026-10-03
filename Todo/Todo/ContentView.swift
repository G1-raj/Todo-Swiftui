import SwiftUI
import Playgrounds

struct ContentView: View {
    
    
    @State private var viewModel = TodoListViewModel(
        service: TodoService()
    )
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            Task {
                                await viewModel.loadTodos()
                            }
                        }
                    }
                    .padding()
                } else {
                    List(viewModel.todos) { todo in
                        NavigationLink {
                            DetailTodoView(todo: todo) {
                                await viewModel.loadTodos()
                            }
                        } label: {
                            TodoCard(
                                title: todo.title,
                                description: todo.description,
                                isCompleted: todo.completed
                            )
                        }
                    }
                }
            }
            .navigationTitle("Todo")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        CreateTodoView {
                            Task {
                                await viewModel.loadTodos()
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(
                                color: .black.opacity(0.25),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                    }
                    .padding(.trailing, 20)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadTodos()
            }
        }
    }
}

#Preview {
    ContentView()
}

//#Playground {
//    _ = 1 + 2
//}
