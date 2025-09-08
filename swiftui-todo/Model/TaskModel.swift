//
//  TaskModel.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import Foundation
/// Modelo de Tarea.
struct Task: Identifiable, Codable {
    /// Identificador de tarea.
    let id: Int
    /// Título de tarea.
    var title: String
    /// Id de usuario.
    var userId: Int
    /// Bandera si se completo.
    var completed: Bool
    /// Mapeo de las claves del JSON a las propiedades del modelo.
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case completed
    }
}
