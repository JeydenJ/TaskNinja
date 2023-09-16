//
//  ContentView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var userName = ""
    @State private var isNameEntered = false
    @State private var isErrorShowing = false
    @State private var errorMessage = ""

    private let characterLimit = 20

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
                    .onTapGesture {

                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }

                Button(action: {
        
                    if validateName() {
                        isNameEntered = true
                    }
                }) {
                    Text("Proceed")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .alert(isPresented: $isErrorShowing) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func validateName() -> Bool {
        if userName.isEmpty {
            errorMessage = "Name cannot be empty."
            isErrorShowing = true
            return false
        } else if userName.count > characterLimit {
            errorMessage = "Name exceeds the character limit of \(characterLimit) characters."
            isErrorShowing = true
            return false
        }
        return true
    }
}


struct MainView: View {
    var userName: String
    @State private var isAppExiting = false
    
    private let exitAlertTitle = "Exit TaskNinja?"
    private let exitAlertMessage = "Are you sure you want to exit TaskNinja?"
    
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
                    title: Text(exitAlertTitle),
                    message: Text(exitAlertMessage),
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
