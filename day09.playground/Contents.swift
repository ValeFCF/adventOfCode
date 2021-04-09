import UIKit

let input = InputHelper.input

let miniInput = """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""

let stringArray = miniInput.components(separatedBy: .newlines)
let intArray: [Int] = stringArray.map {
    Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
}

let preamble = 5

typealias ResultSum = (found: Bool, element: Int)

func findTwoSumSorted(indexToFind: Int,
                      firstIndex: Int,
                      lastIndex: Int) -> ResultSum {
    let elementToFind = intArray[indexToFind]
    let slicedArray = intArray[firstIndex...lastIndex]
    let sortedArray = slicedArray.sorted()
    var leftIndex = 0
    var rightIndex = sortedArray.count - 1
    
    while leftIndex < rightIndex {
        let leftElement = sortedArray[leftIndex]
        let rightElement = sortedArray[rightIndex]
        let currentSum = leftElement + rightElement
        
        if currentSum == elementToFind {
            //print("(\(leftElement), \(rightElement))")
            //print(leftElement * rightElement)
            return (found: true, element: elementToFind)
        } else if currentSum < elementToFind {
            leftIndex += 1
        } else {
            rightIndex -= 1
        }
    }
    
    //print("element not found: \(elementToFind)")
    return (found: false, element: elementToFind)
}

func firstPart() -> Int {
    for index in preamble...intArray.count-1 {
        let resultSum = findTwoSumSorted(indexToFind: index,
                                         firstIndex: index - preamble,
                                         lastIndex: index-1)
        if !resultSum.found {
            return resultSum.element
        }
    }
    return 0
}


print("element not found: \(firstPart())")

