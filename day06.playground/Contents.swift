import UIKit

let miniInput = """
abc

a
b
c

ab
ac

a
a
a
a

b
"""

let input = InputHelper.input

func firstPart() -> Int {
    let answersArray = input.components(separatedBy: "\n\n")
    var valuesToSum = 0

    for element in answersArray {
        let answers = element.replacingOccurrences(of: "\n",
                                                   with: "")
        var answersUniques: [String] = []
        for item in answers {
            if !answersUniques.contains(String(item)) {
                answersUniques.append(String(item))
            }
        }
        
        let valueToSum = answersUniques.count
        
        valuesToSum += valueToSum
    }

    return valuesToSum
}

print("The result of the first part is: \(firstPart())")


func secondPart() -> Int {
    let answersArray = input.components(separatedBy: "\n\n")
    var valuesToSum = 0

    for element in answersArray {
        let answers = element.components(separatedBy: .newlines)
        
        if answers.count == 1 {
            valuesToSum += answers[0].count
        } else {
            var commonArray = Array(answers[0])
            for index in 1...(answers.count-1) {
                let array = Array(answers[index])
                commonArray = commonArray.sameObjects(from: array)
            }
            valuesToSum += commonArray.count
        }
    }

    return valuesToSum
}

print("The result of the second part is: \(secondPart())")



extension Array where Element: Hashable {
    func sameObjects(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.intersection(otherSet))
    }
}
