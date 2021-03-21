public final class ValidationService<Value, Error: Swift.Error>: ValidationQueueService {
    public var validatedObject: Value
    var storage: ValidationStack<Rule<Value, Error>> = ValidationStack()
    
    public required init(validatedObject: Value) {
        self.validatedObject = validatedObject
    }
    
    public func add(error: Error?, _ completion: @escaping (Value) -> Bool) -> Self {
        protocolAdd(error: error, completion)
        return self
    }
    
}
