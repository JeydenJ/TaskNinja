//
//  TaskListView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct Task: Identifiable {
    let id: String
    let name: String
}

struct TaskListView: View {
    @Binding var tasks: [Task]

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.id) { task in
                    Text(task.name)
                }
            }
            .navigationTitle("Task List")
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let emptyTasks: [Task] = []

        return TaskListView(tasks: .constant(emptyTasks))
    }
}
