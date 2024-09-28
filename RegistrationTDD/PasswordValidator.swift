import Foundation

class PasswordValidator {
    
    struct Result {
        let isNumberPresent: Bool
        let isCapitalLetterPresent: Bool
        let isSpecialCharacterPresent: Bool
        let isPasswordLongEnough: Bool
        var isPasswordValid: Bool {
            isNumberPresent
            && isCapitalLetterPresent
            && isSpecialCharacterPresent
            && isPasswordLongEnough
        }
    }
    
    func validate(_ password: String) -> Result {
        
        return Result(
            isNumberPresent: password.isNumberPresent,
            isCapitalLetterPresent: password.isCapitalLetterPresent,
            isSpecialCharacterPresent: password.isSpecialCharacterPresent,
            isPasswordLongEnough: password.count >= 8
        )
    }
}

fileprivate extension String {
    var isNumberPresent: Bool {
         rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    var isCapitalLetterPresent: Bool {
        let regEx  = ".*[A-Z]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    var isSpecialCharacterPresent: Bool {
        let regEx  = ".*[!&^%$#@()/]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
}
