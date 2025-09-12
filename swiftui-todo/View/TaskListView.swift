//
//  TaskListView.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Lista de tareas.
struct TaskListView: View {
    /// Servcio de entorno.
    @Environment(\.taskService) private var taskService: TaskServiceProtocol
    /// View model de tareas.
    @StateObject private var viewModel = TaskViewModel()
    /// Administrador de temas.
    @EnvironmentObject private var themeManager: ThemeManager
    /// View principal.
    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()
            NavigationView {
                List {
                    if viewModel.tasks.isEmpty {
                        Text("No hay tareas")
                            .foregroundColor(themeManager.currentTheme.textColor)
                            .accessibilityIdentifier("emptyListLabel")
                    } else {
                        ForEach(viewModel.tasks) { task in
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                Text(task.title)
                                    .foregroundColor(themeManager.currentTheme.textColor)
                                    .accessibilityIdentifier("task_\(task.id)")
                                    .accessibilityHint("Tarea \(task.id)")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .background(themeManager.currentTheme.backgroundColor)
                .navigationTitle("Tareas")
                .accessibilityIdentifier("taskList")
                .accessibilityLabel("Lista de Tareas")
                .accessibilityElement(children: .contain)
                .toolbar {
                    NavigationLink("Añadir", destination: AddTaskView(viewModel: viewModel))
                        .accessibilityIdentifier("addTaskButton")
                }
                .onAppear {
                    viewModel.setTaskService(taskService)
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}
