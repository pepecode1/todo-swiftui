# ToDoApp

**ToDoApp** es una aplicación iOS desarrollada en **SwiftUI** y **Combine** para gestionar tareas. Permite a los usuarios ver una lista de tareas, añadir nuevas tareas, ver detalles de una tarea, y personalizar el tema visual de la app (azul, verde, rojo). La app utiliza una API externa para cargar tareas y persiste el tema seleccionado usando `@AppStorage`.

## **Características**

- **Lista de tareas**: Muestra una lista de tareas obtenidas desde una API externa.
- **Añadir tareas**: Permite crear nuevas tareas con título y ID de usuario.
- **Detalles de tareas**: Muestra información detallada de cada tarea (título, usuario, estado).
- **Cambio de tema**: Permite personalizar el color de la app (primario, fondo, texto) desde la vista de configuración.
- **Persistencia**: El tema seleccionado se guarda usando `@AppStorage`.
- **Interfaz responsiva**: Diseñada con SwiftUI para una experiencia fluida en iOS.
- **Soporte para modo claro/oscuro**: Los colores se adaptan al tema del sistema (si aplica).

## **Requisitos**

- **Xcode**: Versión 14.0 o superior.
- **iOS**: Versión 15.0 o superior (para compatibilidad con `.scrollContentBackground(.hidden)` usa iOS 16+).
- **Swift**: 5.7 o superior.
- Dependencias externas: Ninguna (usa frameworks nativos de Apple: SwiftUI, Combine).

## **Instalación**

1. Clona el repositorio:
   ```bash
   git clone https://github.com/pepecode1/todo-swiftui.git

## **Screenshots**

