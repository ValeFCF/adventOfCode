import UIKit

let input = InputHelper.miniInput

let stringArray = input.components(separatedBy: .newlines)
let intArray: [Int] = stringArray.map {
    Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
}

func firstPart() -> Int {
    var oneDifferences = 1 // because the array always has 1
    var threeDifferences = 1 // because we need to sum the last number

    let sortedIntArray = intArray.sorted()
    var counter = 1
    while counter < sortedIntArray.count {
        let firstElement = sortedIntArray[counter-1]
        let secondElement = sortedIntArray[counter]
        switch secondElement - firstElement {
        case 1:
            oneDifferences += 1
        case 3:
            threeDifferences += 1
        default:
            fatalError()
        }
        counter += 1
    }

//    let lastMultiplied = (sortedIntArray.last ?? 0) + 3
//    print(lastMultiplied)
//    print(oneDifferences)
//    print(threeDifferences)

    return oneDifferences * threeDifferences
}

print("first part: \(firstPart())")

