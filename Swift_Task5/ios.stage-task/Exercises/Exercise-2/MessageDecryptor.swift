import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        if message.count > 60 {
            return ""
        }
        
        var stack = [Node]()
        stack.append(Node(repeatValue: 1, substring: ""))
        var collectedValue: String = ""
        for char in message {
            if char.isNumber {
                collectedValue.append(char)
                continue
            }
            if char == "[" {
                stack.append(Node(repeatValue: Int(collectedValue) ?? 1, substring: ""))
                collectedValue = ""
                continue
            }
            
            if char == "]" {
                if let node = stack.popLast() {
                    stack[stack.count - 1].substring.append(String(repeating: node.substring, count: node.repeatValue))
                    continue
                }
            }
            
            stack[stack.count - 1].substring.append(char)
            
        }
        return stack.first?.substring ?? ""
    }
    
    struct Node {
        let repeatValue: Int
        var substring: String
    }
}
