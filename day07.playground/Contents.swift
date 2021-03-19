import UIKit

let input = InputHelper.input

let miniInput = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

var rules = input.components(separatedBy: .newlines)
var counter = 0

func removeNoOtherBags() {
    let bagToSearch = "shiny gold"
    rules.removeAll { rule in
        let words = rule.split(separator: " ")
        let nameBag = "\(words[0]) \(words[1])"
        return rule.contains("no other bags") || nameBag == bagToSearch
    }
}

func findBags(bagsToSearch: [String]) {
    var bags: [String] = []
    
    for item in bagsToSearch {
        rules.removeAll { rule in
            let condition = rule.contains(item)
            if condition {
                counter += 1
                let words = rule.split(separator: " ")
                let nameBag = "\(words[0]) \(words[1])"
                bags.append(nameBag)
            }
            return condition
        }
    }
    
    if bags.count > 0 {
        findBags(bagsToSearch: bags)
    }
}

func firstPart() {
    removeNoOtherBags()
    let bagToSearch = "shiny gold"
    findBags(bagsToSearch: [bagToSearch])
    print("first part: \(counter)")
    counter = 0
    rules = miniInput.components(separatedBy: .newlines)
}

firstPart()


/// Second part

let lastMiniInput = """
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
"""

let arrayWithZeros = input.replacingOccurrences(of: "no", with: "0")
var rulesSecond = arrayWithZeros.components(separatedBy: .newlines)
//print(rulesSecond.count)

struct MainBag {
    var nameBag: String
    var howManyHas: Int
    var subBags: [MainBag]
    
    var count: Int {
        1 + subBags.reduce(0) { $0 + $1.count }
    }
    
    var howManySubBags: Int {
        howManyHas * subBags.reduce(0, { (result, mainBag) in
            return result + mainBag.howManyHas + mainBag.howManySubBags
        })
    }
}

let initBag = MainBag(nameBag: "shiny gold", howManyHas: 1, subBags: [])
var tree: [MainBag] = [initBag]

func buildTree(bagsArray: inout [MainBag]) {
    var arrayToSend = 0
    for bagToSearch in bagsArray {
        var countWhile = 0
        innerWhile: while true {
            let rule = rulesSecond[countWhile]
            let words = rule.split(separator: " ")
            let nameBag = "\(words[0]) \(words[1])"
            if nameBag == bagToSearch.nameBag {
                innerForWords: for (index, element) in words.enumerated() {
                    if let number = Int(String(element)), number > 0 {
                        let nameSubBag = "\(words[index + 1]) \(words[index + 2])"
                        
                        let bag = MainBag(nameBag: nameSubBag,
                                          howManyHas: number,
                                          subBags: [])
                        
                        for (index, item) in bagsArray.enumerated() {
                            if item.nameBag == nameBag {
                                bagsArray[index].subBags.append(bag)
                                arrayToSend += 1
                            }
                        }
                    }
                }
                break innerWhile
            } else {
                countWhile += 1
            }
        }
    }
    
    if arrayToSend > 0 {
        for (index, item) in bagsArray.enumerated() {
            if item.subBags.count > 0 {
                buildTree(bagsArray: &bagsArray[index].subBags)
            }
        }
    } else {
        //print("finish")
    }
}

buildTree(bagsArray: &tree)

//print("\n")
//print("tree: \(tree.first!)")
//print("tree children count: \(tree.first!.count)")

print("\n")
print("second part: \(tree.first!.howManySubBags)")


/// https://www.hackingwithswift.com/plus/data-structures/trees
