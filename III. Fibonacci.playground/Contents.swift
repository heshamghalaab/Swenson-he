import Foundation

/*
 III. Write a method in Swift to generate the nth Fibonacci number (1, 1, 2, 3, 5, 8, 13, 21, 34)
 A. recursive approach
 B. iterative approach
 */

class Fibonacci{
    
    enum Approach {
        case recursive
        case iterative
        
        var starterIndex: Int{
            switch self {
            case .recursive: return 1
            case .iterative: return 0
            }
        }
    }
    
    func fib(_ value: Int, withApproach approach: Approach) -> [Int]{
        var values: [Int] = []
        for i in approach.starterIndex...value{
            switch approach {
            case .recursive: values.append(recursiveFibonacci(i))
            case .iterative: values.append(iterativeFibonacci(i))
            }
        }
        return values
    }
    
    private func recursiveFibonacci(_ n: Int) -> Int{
        guard n > 1 else { return n }
        return recursiveFibonacci(n-1) + recursiveFibonacci(n-2)
    }
    
    private func iterativeFibonacci(_ n: Int) -> Int{
        var a = 1
        var b = 1
        guard n > 1 else { return a }
        
        (2...n).forEach { _ in
            (a, b) = (a + b, a)
        }
        return a
    }
}

let fibonacci = Fibonacci()
let recursiveValues = fibonacci.fib(9, withApproach: .recursive)
let iterativeValues = fibonacci.fib(9, withApproach: .iterative)
print("recursiveValues: ", recursiveValues)
print("iterativeValues: ", iterativeValues)

