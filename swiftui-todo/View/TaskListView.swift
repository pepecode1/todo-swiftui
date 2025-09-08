//
//  TaskListView.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Lista de tareas.
struct TaskListView: View {
    /// View model de tareas.
    @StateObject private var viewModel = TaskViewModel()
    /// Administrador de temas.
    @EnvironmentObject private var themeManager: ThemeManager
    /// View principal.
    var body: some View {
        NavigationView {
            List(viewModel.tasks) { task in
                NavigationLink(destination: TaskDetailView(task: task)) {
                    Text(task.title)
                        .foregroundColor(themeManager.currentTheme.textColor)
                }
            }
            .navigationTitle("Tareas")
            .background(themeManager.currentTheme.backgroundColor)
            .toolbar {
                NavigationLink("Añadir", destination: AddTaskView(viewModel: viewModel))
            }
            .onAppear {
                viewModel.loadTasks()
            }
        }
    }
}
