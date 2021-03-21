
protocol ValidationQueueService: class {
    
    /// Generic type of **validatedObject**
    associatedtype Value
    
    /// Generic error type
    associatedtype ErrorValue: Error
    
    /// The object to which the validation will be applied
    var validatedObject: Value { get }
    
    /// Local rules store
    var storage: ValidationStack<Rule<Value, ErrorValue>> { get set }
    
    /// Required init for each implementation
    /// - Parameter validatedObject: Generic object that will be validated
    init(validatedObject: Value)
    
    /**
    Add rule with corresponding error.
    - Parameter error: The error that will be triggered if the rule return **false**
    - Parameter completion: Completion block that takes **validatedObject** and returns **Bool**
    - Returns: Return **Self**
    */
    func add(error: ErrorValue?, _ completion: @escaping (_ value: Value) -> Bool) -> Self
    
    /**
    Start executing rules.
    - Important:
     All rules are executed in the specified order. If executed rule return *false*, immediatly execute **Error Scenario**.
     
     **Success scenario**:
     Triggers *onSuccess:* block that takes *validated object*. Clear *storage*.
     
     **Error scenario**:
     Triggers *onSuccess:* block that takes *corresponding error*. Clear *storage*.
     
    - Parameter onSucces: Takes *validated object*. Triggers if each rule done successfully.
    - Parameter onError: Takes *corresponding error*. Triggers on error and stop eexecution next rules.
    */
    func validate(onSucces: (Value) -> Void, onError: (ErrorValue?) -> Void)
}
