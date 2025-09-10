//
//  TaskService.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import Combine
import Foundation
/// Servicio para tomar tareas.
final class TaskService: TaskServiceProtocol {
    /// Constate de url para servicio GET.
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com/todos")!
    /// Función que obtiene tareas de servicio.
    /// - Returns: Lista de tareas o error.
    func fetchTasks() -> AnyPublisher<[Task], Error> {
        URLSession.shared.dataTaskPublisher(for: baseURL)
            .map(\.data)
            .decode(type: [Task].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    /// Función para crear task con POST.
    /// - Parameter task: body de tarea.
    /// - Returns: tarea exitosa o error.
    func addTask(_ task: Task) -> AnyPublisher<Task, Error> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(task)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Task.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
