//
//  TaskViewModel.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import Combine
import SwiftUI
/// Protocolo.
protocol TaskServiceProtocol {
    /// Obtiene tareas.
    /// - Returns: lista de tareas o error.
    func fetchTasks() -> AnyPublisher<[Task], Error>
    /// Añade tarea.
    /// - Parameter task: tarea a añadir.
    /// - Returns: tarea o error.
    func addTask(_ task: Task) -> AnyPublisher<Task, Error>
}
/// ViewModel de tareas.
class TaskViewModel: ObservableObject {
    /// Lista de tareas.
    @Published var tasks: [Task] = []
    /// Servicio de tareas.
    private let service: TaskServiceProtocol
    /// Lista de cancellables.
    private var cancellables = Set<AnyCancellable>()
    /// Constructor.
    /// - Parameter service: inyección de servicio.
    init(service: TaskServiceProtocol = TaskService()) {
        self.service = service
    }
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
        service.addTask(task)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] newTask in
                self?.tasks.append(newTask)
            })
            .store(in: &cancellables)
    }
}
