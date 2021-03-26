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

typealias TupleData = (stopped: Bool, acc: Int)

func knowTuple(instructions: [String]) -> TupleData {
    var accumulator = 0

    var stopProgram = false
    var positionToRead = 0
    var savedPositions: [Int] = []
    while !stopProgram && positionToRead < instructions.count {
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
    
    return (stopProgram, accumulator)
}

func firstPart() {
    let instructions = input.components(separatedBy: .newlines)
    let acc = knowTuple(instructions: instructions).acc
    print("first part \(acc)")
}

firstPart()

func getIndexArray(instructions: [String]) -> [Int] {
    var JMPorNOPIndex: [Int] = []
    for (index, element) in instructions.enumerated() {
        if element.contains("jmp") || element.contains("nop") {
            JMPorNOPIndex.append(index)
        }
    }
    return JMPorNOPIndex
}

func changeInstructions(_ instructions: [String], position: Int) -> [String] {
    var instructions = instructions
    if instructions[position].contains("jmp") {
        instructions[position] = instructions[position].replacingOccurrences(of: "jmp", with: "nop")
    } else {
        instructions[position] = instructions[position].replacingOccurrences(of: "nop", with: "jmp")
    }
    return instructions
}


func fixInstructionsStep(_ instructions: [String], JMPorNOPIndex: [Int]) -> Int {
    var accumulator = 0
    var counterWhile = 0
    while counterWhile < JMPorNOPIndex.count {
        let instructionsModified = changeInstructions(instructions,
                                                      position: JMPorNOPIndex[counterWhile])
        let tuple = knowTuple(instructions: instructionsModified)
        if tuple.stopped {
            counterWhile += 1
        } else {
            accumulator = tuple.acc
            break
        }
    }
    return accumulator
}

func secondPart() {
    let instructions = input.components(separatedBy: .newlines)
    let JMPorNOPIndex = getIndexArray(instructions: instructions)
    let instructionsFixed = fixInstructionsStep(instructions, JMPorNOPIndex: JMPorNOPIndex)
    print("second part \(instructionsFixed)")
}

secondPart()
