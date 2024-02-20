//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Prism, Hamzzi on 2/6/24.
//

protocol CalculateItem {
    
}

protocol QueueProtocol: DataAccessable {
    mutating func enqueue(element: Element)
    mutating func dequeue() -> Element?
}

struct CalculatorItemQueue<Element: CalculateItem & Equatable>: QueueProtocol {
    private var list = DoublyLinkedList<Element>()
    
    var count: Int {
        return list.count
    }
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var first: Element? {
        return list.first
    }
    
    var last: Element? {
        return list.last
    }
    
    mutating func enqueue(element: Element) {
        list.addLast(element: element)
    }
    
    mutating func dequeue() -> Element? {
        return list.removeFirst()
    }
}

extension CalculatorItemQueue: Equatable {
    static func ==(lhs: CalculatorItemQueue<Element>, rhs: CalculatorItemQueue<Element>) -> Bool {
        return lhs.list == rhs.list
    }
}
