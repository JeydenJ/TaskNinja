//
//  AddTaskView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var tasks: [Task]
    @State private var taskName: String = ""

    var body: some View {
        VStack {
            Text("Add Task")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Task Name", text: $taskName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if !self.taskName.isEmpty {
                    let newTask = Task(id: UUID().uuidString, name: self.taskName)
                    self.tasks.append(newTask)
                    self.taskName = ""
                }
            }) {
                Text("Add Task")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    @State static var tasks: [Task] = []

    static var previews: some View {
        AddTaskView(tasks: $tasks)
    }
}
