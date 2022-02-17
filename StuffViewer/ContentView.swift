//
//  ContentView.swift
//  StuffViewer
//
//  Created by Zev Eisenberg on 2/17/22.
//

import ComposableArchitecture
import SwiftUI

struct ViewState: Equatable {
    var posts: [Post] = []
    var filteredPosts: [Post] = []
    var filteredUser: Int?
}

enum ViewAction: Equatable {
    case postsLoaded([Post])
    case appear
    case filteredUserChanged(Int?)
}

struct ViewEnvironment {
    var fetchPosts: () -> Effect<[Post], Never>
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let viewReducer = Reducer<ViewState, ViewAction, ViewEnvironment> { state, action, environment in
    switch action {
    case let .postsLoaded(newPosts):
        state.posts = newPosts
        if let filteredUser = state.filteredUser {
            state.filteredPosts = state.posts.filter { post in
                post.userId == filteredUser
            }
        }
        else {
            state.filteredPosts = state.posts
        }
        return .none

    case .appear:
        return environment
            .fetchPosts()
            .map(ViewAction.postsLoaded)
            .receive(on: environment.mainQueue)
            .eraseToEffect()

    case .filteredUserChanged(let userId):
        state.filteredUser = userId
        if let filteredUser = state.filteredUser {
            state.filteredPosts = state.posts.filter { post in
                post.userId == filteredUser
            }
        }
        else {
            state.filteredPosts = state.posts
        }
        return .none
    }
}

struct ContentView: View {

    let store: Store<ViewState, ViewAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Picker(
                    selection: viewStore.binding(
                        get: \.filteredUser,
                        send: ViewAction.filteredUserChanged
                    ),
                    content: pickerContent,
                    label: {
                        Text("Filter")
                    }
                )
                    .padding()
                    .pickerStyle(.segmented)
                List {
                    ForEach(viewStore.filteredPosts) { post in
                        Text(post.title)
                    }
                }
                .onAppear {
                    viewStore.send(.appear)
                }
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
            store: .init(
                initialState: .init(
                    posts: [],
                    filteredPosts: [],
                    filteredUser: nil
                ),
                reducer: viewReducer,
                environment: .init(
                    fetchPosts: {
                        return .init(value: [
                            .init(id: 1, userId: 1, title: "foo title", body: "bar title"),
                            .init(id: 2, userId: 2, title: "foo 3", body: "bar title"),
                        ])
                    },
                    mainQueue: .immediate
                )
            )
        )

        ContentView(
            store: .init(
                initialState: .init(
                    posts: [],
                    filteredPosts: [],
                    filteredUser: 2
                ),
                reducer: viewReducer,
                environment: .init(
                    fetchPosts: {
                        return .init(value: [
                            .init(id: 1, userId: 1, title: "foo title", body: "bar title"),
                            .init(id: 2, userId: 2, title: "foo 3", body: "bar title"),
                            .init(id: 3, userId: 2, title: "foo 3", body: "bar title"),
                        ])
                    },
                    mainQueue: .immediate
                )
            )
        )
    }
}
