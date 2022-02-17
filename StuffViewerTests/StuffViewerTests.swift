//
//  StuffViewerTests.swift
//  StuffViewerTests
//
//  Created by Zev Eisenberg on 2/17/22.
//

import XCTest
@testable import StuffViewer
import ComposableArchitecture

class StuffViewerTests: XCTestCase {

    func testFiltering() {

        let user1Post1: Post = .init(id: 1, userId: 1, title: "user 1 post 1", body: "")
        let user1Post2: Post = .init(id: 2, userId: 1, title: "user 1 post 2", body: "")
        let user2Post3: Post = .init(id: 3, userId: 2, title: "user 2 post 3", body: "")

        let mainQueue = DispatchQueue.test

        let store = TestStore(
            initialState: .init(),
            reducer: viewReducer,
            environment: .init(
                fetchPosts: {
                    Effect(value: [
                        user1Post1,
                        user1Post2,
                        user2Post3,
                    ])
                        .delay(for: 10, scheduler: mainQueue)
                        .eraseToEffect()
                },
                mainQueue: mainQueue.eraseToAnyScheduler()
            )
        )

        store.send(.appear)
        mainQueue.advance(by: .seconds(10))
        store.receive(.postsLoaded([
            user1Post1,
            user1Post2,
            user2Post3,
        ])) {
            $0.posts = [
                user1Post1,
                user1Post2,
                user2Post3,
            ]

            $0.filteredPosts = [
                user1Post1,
                user1Post2,
                user2Post3,
            ]
        }

        store.send(.filteredUserChanged(1)) {
            $0.filteredUser = 1
            $0.filteredPosts = [
                user1Post1,
                user1Post2,
            ]
        }
    }

}
