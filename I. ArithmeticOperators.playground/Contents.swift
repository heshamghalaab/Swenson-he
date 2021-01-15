import Foundation

/*
 I. Add arithmetic operators (add, subtract, multiply, divide) to make the following expressions true. You can use any parentheses you’d like. 3 1 3 9 = 12
 */

let operations: [(name: String, calculate: (Double, Double) -> Double)] = [
    ("+", { $0 + $1 }),
    ("-", { $0 - $1 }),
    ("*", { $0 * $1 }),
    ("/", { $0 / $1 })
]


func compute(_ expressions: [String],
             values: [Double],
             target: Double,
             solutions: inout Set<String>) {

    
    // if there is only one expression.
    if expressions.count == 1 {
        /*
         check if the value is the target value we're looking
         for and if the target is matched and we don't already
         have that expression in our set of solutions
         */
        if values[0] == target && !solutions.contains(expressions[0]) {
            print("\(expressions[0]) = \(values[0])")
            solutions.insert(expressions[0])
        }
    } else if expressions.count >= 2 {

        // loop through all of the expressions choosing each as the first expression
        for idx1 in expressions.indices {

            // copy the expressions and values arrays to be sure
            // that we are not modifying the original arrays
            var expressionsTemp = expressions
            var valuesTemp = values

            let firstExpression = expressionsTemp.remove(at: idx1)
            let firstValue = valuesTemp.remove(at: idx1)

            // loop through the remaining expressions to find the second one
            for idx2 in expressionsTemp.indices {
                
                // again, copy the arrays
                var expressionsTemp2 = expressionsTemp
                var valuesTemp2 = valuesTemp

                let secondExpression = expressionsTemp2.remove(at: idx2)
                let secondValue = valuesTemp2.remove(at: idx2)

                // try all possible operations to combine the two expressions
                for operation in operations {
                    
                    let val = operation.calculate(firstValue, secondValue)

                    // combine the expressions into a new string
                    var expression = "\(firstExpression) \(operation.name) \(secondExpression)"
                    if !expressionsTemp2.isEmpty {
                        expression = "(\(expression))"
                    }

                    // recurse by calling compute again
                    // on the reduced list of expressions
                    let newExpression = expressionsTemp2 + [expression]
                    let newValue = valuesTemp2 + [val]
                    compute(newExpression, values: newValue, target: target, solutions: &solutions)
                }
            }
        }
    }
}

func search(values: [Double], target: Double) {
    // create a set to keep track of solutions found so far
    var solutions = Set<String>()
    let expressions = values.map { $0.description }
    compute(expressions,
            values: values,
            target: target,
            solutions: &solutions)
    print("\n\(solutions.count) unique solutions were found")
}

search(values: [3, 1, 3, 9], target: 12)
