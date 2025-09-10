//
//  MockTaskService.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 10/09/25.
//
@testable import swiftui_todo
import SwiftUI
import Combine
/// Mock para simular las llamadas a la API.
final class MockTaskService: TaskServiceProtocol {
    /// Lista de tareas.
    var tasksToReturn: [Task] = []
    /// Bandera para mostrar error.
    var shouldThrowError: Bool = false
    /// Tarea añadida.
    var addedTask: Task?
    func fetchTasks() -> AnyPublisher<[Task], Error> {
        if shouldThrowError {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        return Just(tasksToReturn)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    func addTask(_ task: Task) -> AnyPublisher<Task, Error> {
        if shouldThrowError {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        addedTask = task
        return Just(task)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
