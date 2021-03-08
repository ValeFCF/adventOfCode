import UIKit

let input = InputHelper.getInput()

let miniInput = """
FBFBBFFRLR
"""

let extraInput = """
FFFFFFBLLL
FFFFFFBLLR
"""

func getRow(wordArray: Array<Character>) -> Int {
    var initRowValues = [0, 127]
    var posRow = 0
    var row = 0
    let lettersOfRow = 7
    while posRow < lettersOfRow {
        if posRow == lettersOfRow - 1 {
            if wordArray[posRow] == "F" {
                row = initRowValues.min()!
            } else if wordArray[posRow] == "B" {
                row = initRowValues.max()! //- 1
            }
            //print("row: \(row)")
        } else {
            if wordArray[posRow] == "F" {
                initRowValues = [initRowValues[0], (initRowValues[0] + initRowValues[1])/2]
            } else if wordArray[posRow] == "B" {
                initRowValues = [(1 + initRowValues[0] + initRowValues[1])/2, initRowValues[1]]
            }
        }
        
        posRow += 1
    }
    
    return row
}

func getColumn(wordArray: Array<Character>) -> Int {
    let lettersOfColumn = 10
    var initColumnValues = [0, 7]
    var posColumn = 7
    var column = 0
    while posColumn < lettersOfColumn {
        if posColumn == lettersOfColumn - 1 {
            if wordArray[posColumn] == "L" {
                column = initColumnValues.min()!
            } else if wordArray[posColumn] == "R" {
                column = initColumnValues.max()! //- 1
            }
            //print("column: \(column)")
        } else {
            if wordArray[posColumn] == "L" {
                initColumnValues = [initColumnValues[0], (initColumnValues[0] + initColumnValues[1])/2]
            } else if wordArray[posColumn] == "R" {
                initColumnValues = [(1 + initColumnValues[0] + initColumnValues[1])/2, initColumnValues[1]]
            }
        }
        
        posColumn += 1
    }
    
    return column
}


func getIds() -> [Int] {
    let array = input.components(separatedBy: .newlines)

    var ids: [Int] = []
    
    for element in array {
        //print(element)
        let wordArray = Array(element)
        //print(wordArray)
        
        let row = getRow(wordArray: wordArray) * 8
        let column = getColumn(wordArray: wordArray)
        
        let id = row + column
        //print("id: \(id)")
        ids.append(id)
    }
    
    return ids
}

let ids = getIds()
if let highestId = ids.max() {
    print("The highest id is: \(highestId)")
}

func myOwnId(ids: [Int]) -> Int {
    let sorted = ids.sorted()
    //print(sorted)
    let minSorted = sorted.min()!
    let maxSorted = sorted.max()!

    var allSeats: [Int] = []
    for element in minSorted...maxSorted {
        allSeats.append(element)
    }

    let difference = sorted.difference(from: allSeats)
    return difference[0]
}

let myId = myOwnId(ids: ids)
print("My seat id is: \(myId)")

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
