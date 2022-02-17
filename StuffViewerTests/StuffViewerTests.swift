//
//  StuffViewerTests.swift
//  StuffViewerTests
//
//  Created by Zev Eisenberg on 2/17/22.
//

import XCTest
@testable import StuffViewer

class StuffViewerTests: XCTestCase {

//    func testThings() {
//        let view = ContentView(posts: [])
//
//        XCTAssertEqual(view.posts, [])
//    }

//    func testViewModelLoading() {
//        let viewModel = ViewModel()
//        viewModel.load()
//        XCTAssertEqual(viewModel.filteredPosts.count, 100)
//    }

    func testFiltering() {

        let user1Post1: Post = .init(id: 1, userId: 1, title: "user 1 post 1", body: "")
        let user1Post2: Post = .init(id: 2, userId: 1, title: "user 1 post 2", body: "")
        let user2Post3: Post = .init(id: 3, userId: 2, title: "user 2 post 3", body: "")


        let viewModel = ViewModel(posts: [
            user1Post1,
            user1Post2,
            user2Post3,
        ])

        viewModel.load()

        XCTAssertEqual(viewModel.filteredPosts, [
            user1Post1,
            user1Post2,
            user2Post3,
        ])

        viewModel.filteredUser = 1
        XCTAssertEqual(viewModel.filteredPosts, [
            user1Post1,
            user1Post2,
        ])

        viewModel.filteredUser = 2
        XCTAssertEqual(viewModel.filteredPosts, [
            user2Post3,
        ])

        viewModel.filteredUser = nil
        XCTAssertEqual(viewModel.filteredPosts, [
            user1Post1,
            user1Post2,
            user2Post3,
        ])
    }

}
