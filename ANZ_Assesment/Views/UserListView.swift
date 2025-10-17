//
//  ContentView.swift
//  ANZ_Assesment
//
//  Created by Sanjit Shaw on 16/10/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = ItemsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView(){
                        Image(systemName: "person.3.fill")
                        Text("Loading Users...")
                    }.progressViewStyle(.circular)
                        .controlSize(.large)
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: DetailView(user: user)) {
                            RowView(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .onAppear() {
                Task {
                    if viewModel.users.isEmpty {
                        await viewModel.fetchUsers()
                    }
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

#Preview {
    UserListView()
}
