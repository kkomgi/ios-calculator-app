//
//  CalculatorItemQueueTests.swift
//  CalculatorTests
//
//  Created by Jaehun Lee on 2/6/24.
//

import XCTest
@testable import Calculator

extension CalculatorItemQueue {
    mutating func fromElements(_ elements: Element...) {
        for element in elements {
            enqueue(element: element)
        }
    }
}

final class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue<Double>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_EnqueueWhenQueueIsNotEmpty() {
        // Given
        sut.fromElements(10.0, 20.0)
        let element = 30.0
        let expectedCount = 3
        
        // When
        sut.enqueue(element: element)
        
        // Then
        XCTAssertEqual(expectedCount, sut.count)
    }
    
    func test_EnqueueWhenQueueIsEmpty() {
        // Given
        let element = 30.0
        let expectedFirstValue = 30.0
        let expectedCount = 1
        
        // When
        sut.enqueue(element: element)
        
        // Then
        XCTAssertEqual(expectedFirstValue, sut.first)
        XCTAssertEqual(expectedCount, sut.count)
    }
    
    func test_DequeueWhenListIsNotEmpty() {
        // Given
        sut.fromElements(10.0, 20.0)
        let expectedValue = 10.0
        let expectedCount = 1
        
        // When
        let resultValue = sut.dequeue()
        
        // Then
        XCTAssertEqual(expectedValue, resultValue)
        XCTAssertEqual(expectedCount, sut.count)
    }
    
    func test_DequeueWhenListIsEmpty() {
        // When
        let result = sut.dequeue()
        
        // Then
        XCTAssertNil(result)
    }
}