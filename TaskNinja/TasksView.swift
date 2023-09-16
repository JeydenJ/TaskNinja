//
//  TasksView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct TasksView: View {
    @State private var tasks: [Task] = []
    
    // Computed property to convert [Task] to [TaskProtocol]
    private var taskProtocols: [TaskProtocol] {
        return tasks.map { $0 as TaskProtocol }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Task Management")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Spacer()
                // Navigation link to the AddTaskView
                NavigationLink(destination: AddTaskView(tasks: $tasks)) {
                    Text("Add Task")
                        .font(.headline)
                        .padding()
                }
                // Navigation link to the TaskListView
                NavigationLink(destination: TaskListView(tasks: $tasks)) {
                    Text("View Tasks")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .navigationBarTitle("")
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
