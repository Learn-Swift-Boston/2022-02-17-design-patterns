//
//  ContentView.swift
//  StuffViewer
//
//  Created by Zev Eisenberg on 2/17/22.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Picker(
                selection: $viewModel.filteredUser,
                content: pickerContent,
                label: {
                    Text("Filter")
                }
            )
                .padding()
                .pickerStyle(.segmented)
            List {
                ForEach(viewModel.filteredPosts) { post in
                    Text(post.title)
                }
            }
            .onAppear {
                viewModel.load()
            }
        }
    }

    @ViewBuilder
    func pickerContent() -> some View {
        Image(systemName: "multiply.circle.fill")
            .tag(Optional<Int>.none)
        Text("1")
            .tag(Optional<Int>.some(1))
        Text("2")
            .tag(Optional<Int>.some(2))
        Text("3")
            .tag(Optional<Int>.some(3))
        Text("4")
            .tag(Optional<Int>.some(4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: .init(
                posts: [
                    .init(id: 1, userId: 1, title: "foo title", body: "bar title"),
                    .init(id: 2, userId: 2, title: "foo 3", body: "bar title"),
                ]
            )
        )
    }
}
