import XCTest
@testable import ValidationService
import AppKit

extension String: Error {
    static var unsecurityConnecttion = "Unsecurity connetction"
    static var uncorrectDomain = "Uncorrect domain"
}

final class StringValidationServiceTests: XCTestCase {
    
    var mockService: ValidationService<String, String>?
    
    override func setUp() {}
    override func tearDown() {
        mockService = nil
    }
    
    func testSuccesStorageEmpty() {
        
        mockService = ValidationService(validatedObject: "https://google.com")
        
        mockService?
            .add(error: .unsecurityConnecttion, { (value) -> Bool in
                return value.contains("https")
            })
            .add(error: .uncorrectDomain, { (value) -> Bool in
                return value.contains(".com") || value.contains(".ru") || value.contains(".ua")
            })
            .validate(onSucces: { (value) in
                
            }, onError: { (error) in
                
            })
        
        XCTAssertNil(mockService?.storage.get())
    }
    
    func testErrorStorageEmpty() {
        mockService = ValidationService(validatedObject: "http://google.co")
        
        mockService?
            .add(error: .unsecurityConnecttion, { (value) -> Bool in
                return value.contains("https")
            })
            .add(error: .uncorrectDomain, { (value) -> Bool in
                return value.contains(".com") || value.contains(".ru") || value.contains(".ua")
            })
            .validate(onSucces: { (value) in
                
            }, onError: { (error) in
                
            })
        
        XCTAssertNil(mockService?.storage.get())
    }
    
    func testSuccesFlow() {
        mockService = ValidationService(validatedObject: "https://google.com")
        
        mockService?
            .add(error: .unsecurityConnecttion, { (value) -> Bool in
                return value.contains("https")
            })
            .add(error: .uncorrectDomain, { (value) -> Bool in
                return value.contains(".com") || value.contains(".ru") || value.contains(".ua")
            })
            .validate(onSucces: { (value) in
                XCTAssertEqual(value, "https://google.com")
            }, onError: { (error) in
                XCTAssertNil(error)
            })
    }
    
    func testErrorFlow() {
        mockService = ValidationService(validatedObject: "http://google.co")
        
        mockService?
            .add(error: .unsecurityConnecttion, { (value) -> Bool in
                return value.contains("https")
            })
            .add(error: .uncorrectDomain, { (value) -> Bool in
                return value.contains(".com") || value.contains(".ru") || value.contains(".ua")
            })
            .validate(onSucces: { (value) in
                XCTAssertEqual(value, "https://google.com")
            }, onError: { (error) in
                XCTAssertNotNil(error)
            })
    }
    
    func testErrorQueue() {
        mockService = ValidationService(validatedObject: "https:/google.co")
        var count = 0
        var isExecuteThirdRule = false
        mockService?
            .add(error: .unsecurityConnecttion, { (value) -> Bool in
                count += 1
                return value.contains("https")
            })
            .add(error: .uncorrectDomain, { (value) -> Bool in
                count += 1
                return value.contains("//")
            })
            .add(error: .uncorrectDomain, { (value) -> Bool in
                count += 1
                isExecuteThirdRule = true
                return value.contains(".com") || value.contains(".ru") || value.contains(".ua")
            })
            .validate(onSucces: { (value) in
                
            }, onError: { (error) in
                
            })
        XCTAssertEqual(count, 2)
        XCTAssertFalse(isExecuteThirdRule)
    }
    
    func testMeasure() {
        measure {
            
            mockService = ValidationService(validatedObject: "http://google.co")
            mockService?
                .add(error: .unsecurityConnecttion, { (value) -> Bool in
                    return value.contains("https")
                })
                .add(error: .uncorrectDomain, { (value) -> Bool in
                    return value.contains(".com") || value.contains(".ru") || value.contains(".ua")
                })
                .validate(onSucces: { (value) in
                    print(value)
                }, onError: { (error) in
                    print(error)
                })
        }
    }
}
