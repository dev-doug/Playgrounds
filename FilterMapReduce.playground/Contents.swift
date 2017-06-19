// Usage of .filter, .map, and .reduce

import Foundation

struct User {
    let name, userName, email, city: String
    let birthday: Date
}

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

let user1 = User(name: "Gary Smith", userName: "G Man", email: "gsmith@gmail.com",
                 city: "New York", birthday: dateFormatter.date(from: "1975-01-01")!)
let user2 = User(name: "Nicole Thompson", userName: "Nikki", email: "nic.thom@someplace.com",
                 city: "Austin", birthday: dateFormatter.date(from: "1995-04-13")!)
let user3 = User(name: "Mike Jones", userName: "JumpUp", email: "bballfan@gmail.com",
                 city: "Chicago", birthday: dateFormatter.date(from: "1988-05-27")!)
let user4 = User(name: "Mary Williams", userName: "PieFromTheHeart", email: "mary@pies.com",
                 city: "Boston", birthday: dateFormatter.date(from: "1952-11-04")!)
let user5 = User(name: "John Brown", userName: "Nazcar4Life", email: "jb1983@gmail.com",
                 city: "Tampa", birthday: dateFormatter.date(from: "1983-07-16")!)
let user6 = User(name: "Jennifer Davis", userName: "JeniOnTheCulDeSac", email: "jennifer4@gmail.com",
                 city: "San Fransisco", birthday: dateFormatter.date(from: "1979-05-22")!)

let allUsers = [user1, user2, user3, user4, user5, user6]


// Filter

func usersWithGmail(users: [User]) -> [User] {
    var gmailUsers = [User]()

    for user in users {
        if user.email.hasSuffix("@gmail.com") {
            gmailUsers.append(user)
        }
    }

    return gmailUsers
}

let gmailUsers = usersWithGmail(users: allUsers)

let filteredGmailUsers = allUsers.filter { return $0.email.hasSuffix("@gmail.com") }


// Map

func ageSecondsOf(users: [User]) -> [Double] {
    var userAges = [Double]()

    for user in users {
        userAges.append(Date().timeIntervalSince(user.birthday))
    }

    return userAges
}

let userAgeSeconds = ageSecondsOf(users: allUsers)

let mappedUserAgeSecond = allUsers.map { return Date().timeIntervalSince($0.birthday) }

// Reduce

func sum(_ array: [Double]) -> Double {
    var total: Double = 0

    for num in array {
        total += num
    }

    return total
}

let totalUserAge = sum(userAgeSeconds)

let reducedTotal = userAgeSeconds.reduce(0, +)

var onHandCash = 100.00

let expenditures = [10.57, 7.83, 1.25, 32.73]

onHandCash = expenditures.reduce(onHandCash, -)

let annualInterestRates = [3.5, 2.7, 5.5, 4.2, 3.0]

onHandCash = annualInterestRates.reduce(onHandCash, {$0 * ((100.0 + $1) / 100.0)} )

print(onHandCash)

