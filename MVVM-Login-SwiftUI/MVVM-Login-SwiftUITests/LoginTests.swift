//
//  LoginTests.swift
//  MVVM-Login-SwiftUITests
//
//  Created by Sachin Daingade on 23/01/22.
//

import XCTest
@testable import MVVM_Login_SwiftUI

class LoginTests: XCTestCase {
    
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
    
    func testLogin() {
        let expec = expectation(description: "User login request")
        let credentials = Credentials(email: "johnios9952@gmail.com", password: "123456")
        NetworkServices.shared.login(credentials: credentials) { result in
            switch result {
            case .failure(let error):
                XCTFail(" user login failed \(error.localizedDescription)")
                expec.fulfill()
            case .success(let isLogin):
                print("User login success \(isLogin)")
                expec.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testLoginFail() {
        let expec = expectation(description: "User login request")
        let credentials = Credentials(email: "johnios9952@gmail.com", password: "1234567")
        NetworkServices.shared.login(credentials: credentials) { result in
            switch result {
            case .failure(let error):
                XCTFail(" user login failed \( error.errorDescription)")
                expec.fulfill()
            case .success(let isLogin):
                print("User login success \(isLogin)") 
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
