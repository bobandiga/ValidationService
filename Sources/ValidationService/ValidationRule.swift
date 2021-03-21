import Foundation

public struct Rule<Value, Error> {
    public let error: Error?
    public let validation: (Value) -> Bool
    
    public init(error: Error?, validation: @escaping (Value) -> Bool) {
        self.error = error
        self.validation = validation
    }
}
