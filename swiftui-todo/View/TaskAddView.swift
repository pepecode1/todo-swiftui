//
//  TaskAddView.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Vista para añdir nueva tarea (formulario).
struct AddTaskView: View {
    /// View model de tareas.
    @ObservedObject var viewModel: TaskViewModel
    /// Título de tarea nueva.
    @State private var title = ""
    /// Descripción de tarea nueva.
    @State private var description = ""
    /// Acción de dismiss.
    @Environment(\.dismiss) var dismiss
    /// Administrador de temas.
    @EnvironmentObject private var themeManager: ThemeManager
    /// Vista principal.
    var body: some View {
        VStack {
            TextField("Título", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding()
                .foregroundColor(themeManager.currentTheme.textColor)
            Button("Guardar") {
                let newTask = Task(id: 1, title: title, userId: 0, completed: false)
                viewModel.addTask(newTask)
                dismiss()
            }
            .disabled(title.isEmpty)
            .foregroundColor(.white)
            .padding()
            .background(themeManager.currentTheme.primaryColor)
            .cornerRadius(8)
            Spacer()
        }
        .background(themeManager.currentTheme.backgroundColor)
        .navigationTitle("Nueva Tarea")
    }
    /// Función para obtener último identificador.
    /// - Returns: identificador nuevo.
    private func getLastId() -> Int {
        if let lastId = viewModel.tasks.last?.id {
            return lastId + 1
        }
        return 0
    }
}
