//Your task is to make a function that can take any non-negative integer as a argument and return it with it's digits in descending order. Essentially, rearrange the digits to create the highest possible number.

import Foundation

func descendingOrder(of number: Int) -> Int {
    let numString = String(number)

    let sortedCharsArray = numString.characters.sorted(by: >) // { return $0 > $1 })

    let sortedString = String(sortedCharsArray)

    if let sortedNumber = Int(sortedString) {
        return sortedNumber
    } else {
        return -1
    }

}

descendingOrder(of: 0) // 0
descendingOrder(of: 15) // 51
descendingOrder(of: 123456789) // 987654321
