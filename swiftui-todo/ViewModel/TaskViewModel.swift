//
//  TaskViewModel.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import Combine
import SwiftUI
/// ViewModel de tareas.
class TaskViewModel: ObservableObject {
    /// Lista de tareas.
    @Published var tasks: [Task] = []
    /// Servicio de tareas.
    private let service = TaskService()
    /// Lista de cancellables.
    private var cancellables = Set<AnyCancellable>()
    /// Función de carga de tareas desde servicio.
    func loadTasks() {
        service.fetchTasks()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] tasks in
                self?.tasks = tasks
            })
            .store(in: &cancellables)
    }
    /// Función para añdir una tarea.
    /// - Parameter task: tarea que se agregará.
    func addTask(_ task: Task) {
        service.createTask(task)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] newTask in
                self?.tasks.append(newTask)
            })
            .store(in: &cancellables)
    }
}
