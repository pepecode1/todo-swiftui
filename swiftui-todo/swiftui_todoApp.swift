//
//  swiftui_todoApp.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//

import SwiftUI

@main
struct swiftui_todoApp: App {
    /// Administrador de temas.
    @StateObject private var themeManager = ThemeManager()
    /// Inicializador.
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    /// App.
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environment(\.taskService, taskService)
        }
    }
    /// Mock de service.
    private var taskService: TaskServiceProtocol {
        if CommandLine.arguments.contains("UITesting") {
            let mockService = TaskServiceMock()
            mockService.tasksToReturn = [
                Task(id: 1, title: "Tarea 1", userId: 1, completed: false),
                Task(id: 2, title: "Tarea 2", userId: 1, completed: true)
            ]
            print("MockTaskService configurado con \(mockService.tasksToReturn.count) tareas")
            return mockService
        }
        return TaskService()
    }
}
