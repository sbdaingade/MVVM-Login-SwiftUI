//
//  PhotosTests.swift
//  MVVM-Login-SwiftUITests
//
//  Created by Sachin Daingade on 17/02/22.
//

import XCTest
@testable import MVVM_Login_SwiftUI

class PhotosTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPhotos() {
        let expec = expectation(description: "User photos request")
        PhotoNetworkServices.getPhotos { result in
            switch result {
            case .failure(let error):
                XCTFail(" user photos failed \(error.localizedDescription)")
                expec.fulfill()
            case .success(let photos):
                print("User photos success \(photos.first?.title ?? "")")
                expec.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
