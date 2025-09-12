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
    private var service: TaskServiceProtocol
    /// Lista de cancellables.
    private var cancellables = Set<AnyCancellable>()
    /// Constructor.
    init() {
        self.service = TaskService() // Valor por defecto para la inicialización
    }
    /// Inyección de servicio para pruebas.
    /// - Parameter service: inyección de servicio.
    func setTaskService(_ service: TaskServiceProtocol) {
        self.service = service
        loadTasks()
    }
    /// Función de carga de tareas desde servicio.
    func loadTasks() {
        service.fetchTasks()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                    self.tasks = []
                }
            }, receiveValue: { [weak self] tasks in
                print("Tareas cargadas: \(tasks)")
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
                print("Tarea añadida: \(newTask)")
                self?.tasks.append(newTask)
                print("Tareas: \(self?.tasks)")
            })
            .store(in: &cancellables)
    }
}
