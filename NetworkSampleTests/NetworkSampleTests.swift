//
//  NetworkSampleTests.swift
//  NetworkSampleTests
//
//  Created by Daniel Shelley on 12/10/22.
//

import XCTest
@testable import NetworkSample

final class NetworkSampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndpointCreation() throws {
        
        let allZip = URL(string: Endpoint.allByZip(zip: "31023").url)
        XCTAssertNotNil(allZip)
        
        let repsState = URL(string: Endpoint.repsByState(state: "NV").url)
        XCTAssertNotNil(repsState)
        
        let repsName = URL(string: Endpoint.repsByName(name: "smith").url)
        XCTAssertNotNil(repsName)
        
        let senState = URL(string: Endpoint.senatorByState(state: "NV").url)
        XCTAssertNotNil(senState)
        
        let senName = URL(string: Endpoint.senatorByName(name: "johnson").url)
        XCTAssertNotNil(senName)
    }
    
    func testAllEndpoint() async throws {
        let url = Endpoint.allByZip(zip: "31023").url
        let result:CongressMembers? = await Networking().request(url: url)
        XCTAssertFalse(result?.results.isEmpty ?? true)
    }
    
    func testRepNameEndpoint() async throws {
        let url = Endpoint.repsByName(name: "smith").url
        let result:CongressMembers? = await Networking().request(url: url)
        XCTAssertFalse(result?.results.isEmpty ?? true)
    }
    
    func testRepStateEndpoint() async throws {
        let url = Endpoint.repsByState(state: "NV").url
        let result:CongressMembers? = await Networking().request(url: url)
        XCTAssertFalse(result?.results.isEmpty ?? true)
    }
    
    func testStateNameEndpoint() async throws {
        let url = Endpoint.senatorByName(name: "johnson").url
        let result:CongressMembers? = await Networking().request(url: url)
        XCTAssertFalse(result?.results.isEmpty ?? true)
    }
    
    func testSenStateEndpoint() async throws {
        let url = Endpoint.senatorByState(state: "ME").url
        let result:CongressMembers? = await Networking().request(url: url)
        XCTAssertFalse(result?.results.isEmpty ?? true)
    }
    
}
