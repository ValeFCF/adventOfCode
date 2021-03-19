import UIKit

let input = InputHelper.input

let miniInput = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""

func firstPart() {
    let instructions = input.components(separatedBy: .newlines)
    var accumulator = 0

    var stopProgram = false
    var positionToRead = 0
    var savedPositions: [Int] = []
    while !stopProgram {
        let instruction = instructions[positionToRead]
        let words = instruction.split(separator: " ")
        let operation = words[0]
        let argument = Int(words[1])

        switch operation {
        case "acc":
            if let argument = argument {
                accumulator += argument
            }
            positionToRead += 1
        case "jmp":
            if let argument = argument {
                positionToRead += argument
            }
        case "nop":
            positionToRead += 1
        default:
            stopProgram = true
        }
        
        if savedPositions.contains(positionToRead) {
            stopProgram = true
        } else {
            savedPositions.append(positionToRead)
        }
    }

    print("first part \(accumulator)")
}

firstPart()
