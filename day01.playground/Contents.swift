import UIKit

let input = """
    1655
    1384
    1752
    1919
    1972
    1766
    1852
    1835
    1408
    1721
    1879
    1846
    1394
    1577
    1588
    1097
    1748
    1585
    765
    1375
    1806
    1785
    1824
    1847
    1037
    1531
    1989
    1570
    1625
    1600
    1832
    1927
    1691
    1593
    1936
    1812
    570
    1391
    1883
    1592
    1875
    1185
    1903
    855
    1331
    1742
    1884
    1356
    1944
    1994
    1556
    1271
    1572
    1661
    1914
    1905
    1581
    1634
    1252
    1657
    989
    1907
    1998
    1040
    1833
    1612
    1725
    1680
    1869
    1900
    1550
    1768
    1727
    1930
    1810
    1841
    734
    1779
    1774
    1825
    1446
    1259
    1552
    1310
    1885
    1689
    1929
    1959
    787
    1642
    1890
    1164
    1986
    1796
    1465
    1217
    1741
    1480
    1683
    1808
    1058
    1970
    1361
    2003
    1898
    1668
    1754
    1773
    1235
    1158
    1975
    1479
    1995
    1648
    1023
    883
    1553
    1658
    1794
    1747
    1978
    1268
    1966
    1192
    1886
    1471
    1548
    1819
    1551
    1958
    1732
    1676
    1745
    1501
    1858
    1652
    1596
    473
    1314
    1814
    1409
    1877
    1344
    1735
    1635
    1273
    871
    1643
    1599
    1565
    1695
    1803
    1764
    1778
    1823
    1831
    1701
    282
    1089
    1623
    1639
    1568
    1469
    1674
    1818
    1992
    1597
    1711
    1359
    1851
    1496
    1630
    1755
    1529
    1881
    1718
    1916
    1325
    1578
    1441
    1722
    1545
    1472
    1783
    1497
    1791
    1183
    1926
    1937
    1255
    1095
    1451
    1395
    1665
    1432
    1693
    1821
    1938
    1941
    2002
"""

let stringArray = input.components(separatedBy: .newlines)
let intArray: [Int] = stringArray.map {
    Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!
}

func firstPart() -> Int {
    var position = 0
    var done = false
    var result = 0

    while done == false {
        let firstValue = intArray[position]
        for (index, value) in intArray.enumerated() {
            if position != index {
                if (firstValue + value) == 2020 {
                    result = firstValue * value
                    done = true
                    break
                }
            }
        }
        position += 1
    }

    return result
}

print("firstPart: \(firstPart())")

func findTwoSumSorted() {
    let sortedArray = intArray.sorted()
    var leftIndex = 0
    var rightIndex = sortedArray.count - 1
    var leftRight = true
    
    while leftIndex < rightIndex {
        let leftElement = sortedArray[leftIndex]
        let rightElement = sortedArray[rightIndex]
        let currentSum = leftElement + rightElement
        
        leftRight = !leftRight
        
        if currentSum == 2020 {
            print("(\(leftElement), \(rightElement))")
            print(leftElement * rightElement)
            return
        } else if currentSum < 2020 {
            leftIndex += 1
        } else {
            rightIndex -= 1
        }
    }
}

//print("other approach: \(findTwoSumSorted())")

func findThreeSumSorted() -> Int {
    let sortedArray = intArray.sorted()
    var leftIndex = 0
    var midIndex = 1
    var rightIndex = sortedArray.count - 1
    var result = 0
    
    while leftIndex + 1 < rightIndex {
        let leftElement = sortedArray[leftIndex]
        let midElement = sortedArray[midIndex]
        let rightElement = sortedArray[rightIndex]
        let currentSum = leftElement + midElement + rightElement
        
        if currentSum == 2020 {
            result = leftElement * midElement * rightElement
            break
        } else if currentSum < 2020 {
            midIndex += 1
        } else {
            rightIndex -= 1
        }
    }
    return result
}

print("thirdPart: \(findThreeSumSorted())")
