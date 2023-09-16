//
//  TaskDetailView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 15/9/2023.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task
    
    var body: some View {
        VStack {
            Text("Task Details")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("Name: \(task.name)")
                .padding()
            Text("Description: \(task.description)")
                .padding()
            Text("Due Date: \(task.dueDate, style: .date)")
                .padding()
            Text("Priority: \(task.priority.rawValue)")
                .padding()
            Text("Type: \(task.type.rawValue)")
                .padding()
            
            
            Spacer()
        }
        .padding()
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = Task(id: UUID(), name: "Sample Task", description: "This is a sample task description.", dueDate: Date(), priority: .high, type: .work)
        
        return TaskDetailView(task: sampleTask)
    }
}
