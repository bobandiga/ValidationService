import Foundation

struct ValidationStack<Value> {
    private var array: [Value] = []
    
    public init() {}
    
    public init(arrayLiteral elements: Value...) {
        array = elements
    }
}

extension ValidationStack {
    mutating func add(_ value: Value) {
        array.append(value)
    }
    
    mutating func get() -> Value? {
        if array.isEmpty { return nil }
        return array.removeFirst()
    }
    
    mutating func clear() {
        array = []
    }
}
