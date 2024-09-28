import XCTest

@testable import RegistrationTDD

class PasswordValidatorTests: XCTestCase {
    
    private var validator: PasswordValidator!
    
    override func setUp() async throws {
        try await super.setUp()
        
        validator = PasswordValidator()
        
    }
    
    func test_whenPasswordContainsANumber_doesContainNumberReturnsTrue() {
        //given
        let password = "password1"
        
        //when
        let result = validator.validate(password)
        
        //then
        XCTAssertTrue(result.isNumberPresent)
    }
    
    func test_whenPasswordDoesntContainNumber_isNumberPresentIsFalse() {
        //given
        let passwords = ["", "password", "pass"]
        
        for password in passwords {
            //when
            let result = validator.validate(password)
            
            //then
            XCTAssertFalse(result.isNumberPresent)
        }
    }
    
    func test_whenPasswordDoesntContainCapitalLetter_isCapitalLetterPresentIsFalse() {
        //given
        let password = "password"
        
        //when
        let result = validator.validate(password)
        
        //then
        XCTAssertFalse(result.isCapitalLetterPresent)
    }
    
    func test_whenPasswordContainsCapitalLetter_isCapitalLetterPresentIsTrue() {
        //given
        let passwords = ["Password", "blaBla", "flowFlowFlow1"]
        
        for password in passwords {
            //when
            let result = validator.validate(password)
            
            //then
            XCTAssertTrue(result.isCapitalLetterPresent)
        }
    }
    
    func test_whenPasswordDoesntContainSpecialCharacter_thenBooleanIsFalse() {
        //given
        let password = "password"
        
        //when
        let result = validator.validate(password)
        
        //then
        XCTAssertFalse(result.isSpecialCharacterPresent)
    }
    
    func test_whenPasswordContainsSpecialCharacter_thenBooleanIsTrue() {
        //given
        let passwords = ["Password@", "bla$Bla", "flow#(FlowFlow1"]
        
        for password in passwords {
            //when
            let result = validator.validate(password)
            
            //then
            XCTAssertTrue(result.isSpecialCharacterPresent)
        }
    }
    
    func test_whenPasswordIsLessThan8Character_thenBooleanIsFalse() {
        //given
        let password = "passwo"
        
        //when
        let result = validator.validate(password)
        
        //then
        XCTAssertFalse(result.isPasswordLongEnough)
    }
    
    func test_whenPasswordIsMoreOrEqualTo8Character_thenBooleanIsTrue() {
        //given
        let password = "password"
        
        //when
        let result = validator.validate(password)
        
        //then
        XCTAssertTrue(result.isPasswordLongEnough)
    }
    
    func test_whenAConditionIsNotFulfilled_thenPasswordIsNotValid() {
        
        let passwords: [String: Bool] = [
            "password!1": false,
            "password!1A": true,
            "pass": false,
            "": false,
            "abdFes@asf1": true,
            "@1232ewedaW": true,
            "asaasd111": false
        ]
        
        for (password, isValid) in passwords {
            //when
            let result = validator.validate(password)
            
            //then
            XCTAssertEqual(result.isPasswordValid, isValid, "\(password) is expected tot be valid = \(isValid)")
        }
    }
}
