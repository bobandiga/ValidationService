import Foundation

extension ValidationQueueService {
    
    func protocolAdd(error: ErrorValue?, _ completion: @escaping (_ value: Value) -> Bool) {
        let rule = Rule(error: error, validation: completion)
        storage.add(rule)
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
