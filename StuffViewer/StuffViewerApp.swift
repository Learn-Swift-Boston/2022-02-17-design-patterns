//
//  StuffViewerApp.swift
//  StuffViewer
//
//  Created by Zev Eisenberg on 2/17/22.
//

import SwiftUI

@main
struct StuffViewerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: .init(
                    initialState: .init(),
                    reducer: viewReducer,
                    environment: .init(
                        fetchPosts: {
                            URLSession.shared
                                .dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
                                .map(\.0)
                                .decode(type: [Post].self, decoder: JSONDecoder())
                                .replaceError(with: [])
                                .eraseToEffect()
                        },
                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                    )
                )
            )
        }
    }
}
