/*The input is a string 's' of digits. Cut the string into chunks (a chunk here is a substring of the initial string) of size 'c' (ignore the last chunk if its size is less than 'c').

 If a chunk represents an integer such as the sum of the cubes of its digits is divisible by 2, reverse that chunk; otherwise rotate it to the left by one position. Put together these modified chunks and return the result as a string.

 If
    'c' is <= 0 or if 's' is empty return ""
    'c' is greater (>) than the length of 's' it is impossible to take a chunk of size 'c' hence return "".

 */

import Foundation

func revRot(_ s: String, _ c: Int) -> String {

    guard c > 0 && s != "" && c <= s.characters.count else {
        return ""
    }

    if let chunks = Array(s.characters).chunks(c) {
        let analyzedChunks = analyzeAndTransformChunks(chunks)

        return concatCharChunks(analyzedChunks)
    }

    return ""
}

func concatCharChunks(_ chunks: [[Character]]) -> String {
    var string = ""
    for chunk in chunks {
        string += String(chunk)
    }
    return string
}

func analyzeAndTransformChunks(_ chunks: [[Character]]) -> [[Character]] {
    var analyzedChunks = [[Character]]()
    for chunk in chunks {
        if isSumOfDigitsCubesEven(chunk) {
            analyzedChunks.append(chunk.reversed())
        } else {
            analyzedChunks.append(Array(chunk[1..<chunk.count]) + [chunk[0]])
        }
    }
    return analyzedChunks
}

func isSumOfDigitsCubesEven(_ digitCharacters: [Character]) -> Bool {
    var sum = 0
    for digitChar in digitCharacters {
        if let number = Int(String(digitChar)) {
            sum += Int(pow(Double(number), 3.0))
        }
    }
    return sum%2 == 0
}

extension Array {
    func chunks(_ ofSize: Int) -> [[Element]]? {
        if self.count < ofSize {
            return nil
        } else {
            if let tail = Array(self[ofSize..<self.count]).chunks(ofSize) {
                return [Array(self[0..<ofSize])] + tail
            } else {
                return [Array(self[0..<ofSize])]
            }
        }
    }
}

revRot("123456987654", 6) // "234561876549"
revRot("123456987653", 6) // "234561356789"
revRot("66443875", 4) // "44668753"
revRot("66443875", 8) // "64438756"
revRot("664438769", 8) // "67834466"
revRot("123456779", 8) // "23456771"
revRot("", 8) // ""
revRot("123456779", 0) // ""
revRot("563000655734469485", 4) // "0365065073456944"
