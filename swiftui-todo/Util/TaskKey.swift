//
//  TaskKey.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 11/09/25.
//
import SwiftUI
/// Llaves de service.
struct TaskServiceKey: EnvironmentKey {
    static let defaultValue: TaskServiceProtocol = TaskService()
}
/// Valores de ambiente.
extension EnvironmentValues {
    var taskService: TaskServiceProtocol {
        get { self[TaskServiceKey.self] }
        set { self[TaskServiceKey.self] = newValue }
    }
}
