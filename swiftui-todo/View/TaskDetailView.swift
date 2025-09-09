//
//  TaskDetailView.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Detalle de tarea.
struct TaskDetailView: View {
    /// Tarea de vista principal (lista).
    let task: Task
    /// Administrador de temas.
    @EnvironmentObject private var themeManager: ThemeManager
    /// View principal.
    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()
            VStack {
                Text(task.title)
                    .font(.title)
                    .foregroundColor(themeManager.currentTheme.textColor)
                Text(task.completed ? "Completada" : "Pendiente")
                    .foregroundColor(task.completed ? .green : .red)
                Spacer()
            }
        }
        .navigationTitle("Detalles")
        .background(themeManager.currentTheme.backgroundColor)
    }
}
/// Preview.
#Preview {
    TaskDetailView(task: Task(id: 0, title: "Preview", userId: 0, completed: true))
}
