public class ValidationService<Value, Error: Swift.Error>: ValidationQueueService {
    public var validatedObject: Value
    public private(set) var storage: ValidationStack<Rule<Value, Error>>
    
    public required init(validatedObject: Value) {
        self.validatedObject = validatedObject
        self.storage = ValidationStack()
    }
    
    public func add(error: Error?, _ completion: @escaping (Value) -> Bool) -> Self {
        let rule = Rule(error: error, validation: completion)
        storage.add(rule)
        return self
    }
    
    public func validate(onSucces: (Value) -> Void, onError: (ErrorValue?) -> Void) {
        while let obj = storage.get() {
            if obj.validation(validatedObject) {
                continue
            } else {
                storage.clear()
                onError(obj.error)
                return
            }
        }
        onSucces(validatedObject)
    }
    
}
