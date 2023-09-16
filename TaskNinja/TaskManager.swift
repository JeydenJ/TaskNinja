//
//  TaskManager.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 15/9/2023.
//

import Foundation

// Define a protocol for common task properties
protocol TaskProtocol {
    var id: UUID { get }
    var name: String { get set }
    var description: String { get set }
    var dueDate: Date { get set }
    var priority: Priority { get set }
}


// Define a protocol for managing tasks
protocol TaskManagerProtocol {
    func addTask(_ task: TaskProtocol)
    func updateTask(_ task: TaskProtocol)
    func deleteTask(_ task: TaskProtocol)
    func getTasks() -> [TaskProtocol]
}

// Define a base enum for task priority
enum Priority: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

// Implement Task as a class conforming to TaskProtocol
class Task: Identifiable, Hashable, TaskProtocol {
    let id: UUID
    var name: String
    var description: String
    var dueDate: Date
    var priority: Priority
    var type: TaskType
    
    init(id: UUID, name: String, description: String, dueDate: Date, priority: Priority, type: TaskType) {
        self.id = id
        self.name = name
        self.description = description
        self.dueDate = dueDate
        self.priority = priority
        self.type = type
    }
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// PersonalTask that conforms to TaskProtocol
struct PersonalTask: TaskProtocol {
    let id: UUID
    var name: String
    var description: String
    var dueDate: Date
    var priority: Priority
    var isFamilyEvent: Bool
}

// WorkTask that conforms to TaskProtocol
struct WorkTask: TaskProtocol {
    let id: UUID
    var name: String
    var description: String
    var dueDate: Date
    var priority: Priority
    var project: String
}

// TaskManager as a class conforming to TaskManagerProtocol
class TaskManager: TaskManagerProtocol {
    static let shared = TaskManager()
    
    private var tasks: [TaskProtocol] = []
    
    func addTask(_ task: TaskProtocol) {
        tasks.append(task)
    }
    
    func updateTask(_ task: TaskProtocol) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
    
    func deleteTask(_ task: TaskProtocol) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func getTasks() -> [TaskProtocol] {
        return tasks
    }
    func createTask(name: String, description: String, dueDate: Date, priority: Priority, type: TaskType) -> Task {
        let newTask = Task(id: UUID(), name: name, description: description, dueDate: dueDate, priority: priority, type: type)
        tasks.append(newTask)
        return newTask
    }
}
