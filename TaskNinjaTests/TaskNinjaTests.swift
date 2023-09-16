//
//  TaskNinjaTests.swift
//  TaskNinjaTests
//
//  Created by Jeyden Johnson on 16/9/2023.
//

import XCTest
@testable import TaskNinja

final class TaskNinjaTests: XCTestCase {

    var taskManager: TaskManager!

        override func setUpWithError() throws {
            super.setUp()
            // Initialize your TaskManager or relevant class here
            taskManager = TaskManager()
        }

        override func tearDownWithError() throws {
            // Clean up after each test if necessary
            taskManager = nil
            super.tearDown()
        }

        func testTaskCreation() throws {
            // Define test data
            let taskName = "Test Task"
            let taskDescription = "This is a test task"
            let dueDate = Date()
            let priority = Priority.medium
            let type = TaskType.work

            // Create the task
            let newTask = taskManager.createTask(name: taskName, description: taskDescription, dueDate: dueDate, priority: priority, type: type)

            // Assert that the task was created correctly
            XCTAssertEqual(newTask.name, taskName)
            XCTAssertEqual(newTask.description, taskDescription)
            XCTAssertEqual(newTask.dueDate, dueDate)
            XCTAssertEqual(newTask.priority, priority)
        }
    
    func testTaskDeletion() throws {
            // Define test data
            let taskName = "Test Task"
            let taskDescription = "This is a test task"
            let dueDate = Date()
            let priority = Priority.medium
            let type = TaskType.work

            // Create the task
            let newTask = taskManager.createTask(name: taskName, description: taskDescription, dueDate: dueDate, priority: priority, type: type)

            // Delete the task
            taskManager.deleteTask(newTask)

            // Verify that the task has been deleted
            XCTAssertTrue(taskManager.getTasks().isEmpty)
        }
    }
