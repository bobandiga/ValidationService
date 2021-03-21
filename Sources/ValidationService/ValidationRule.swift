import Foundation

struct Rule<Value, Error> {
    public var error: Error?
    public var validation: (Value) -> Bool
    
    public init(error: Error?, validation: @escaping (Value) -> Bool) {
        self.error = error
        self.validation = validation
    }
}
