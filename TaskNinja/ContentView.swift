//
//  ContentView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var userName = ""
    @State private var isNameEntered = false
    
    var body: some View {
        if isNameEntered {
            MainView(userName: userName)
        } else {
            VStack {
                Image(systemName: "person.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Welcome to TaskNinja!")
                Text("Please enter your name:")
                
                TextField("Name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    isNameEntered = true
                }) {
                    Text("Proceed")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct MainView: View {
    var userName: String
    @State private var isAppExiting = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("TaskNinja")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Text("Hello, \(userName)!")
                    .font(.title)
                    .padding(.top)
                
                Spacer()
                
                NavigationLink(destination: TasksView()) {
                    Text("Tasks")
                        .font(.headline)
                        .padding()
                }
                
                Button(action: {
                }) {
                    Text("Settings")
                        .font(.headline)
                        .padding()
                }
                
                Button(action: {
                    isAppExiting = true
                }) {
                    Text("Exit")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .navigationBarTitle("")
            .alert(isPresented: $isAppExiting) {
                Alert(
                    title: Text("Exit TaskNinja?"),
                    message: Text("Are you sure you want to exit TaskNinja?"),
                    primaryButton: .destructive(Text("Exit")) {
                        exit(0)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
