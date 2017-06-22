//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

func loadFile(_ filename: String, completion: @escaping (Data) -> Void) {

    DispatchQueue.global(qos: .background).async {

        let filenameComponents = filename.components(separatedBy: ".")

        guard let filePath = Bundle.main.path(forResource: filenameComponents[0], ofType: filenameComponents[1]) else {
            fatalError("Unable to create filePath.")
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            fatalError("Unable to create Data from file.")
        }

        DispatchQueue.main.async { completion(data) }
    }
}


func serializeJSON(data: Data, completion: @escaping ([String : Any]) -> Void) {

    DispatchQueue.global(qos: .background).async {

        guard let json = try? JSONSerialization.jsonObject(with: data) as! [String : Any] else {
            fatalError("Unable to serialize JSON.")
        }

        DispatchQueue.main.async { completion(json) }
    }
}

let startStamp = Date()

print("<<< Begin loadFile - \(Date().timeIntervalSince(startStamp))\n")

loadFile("tasks.json", completion: { data in

    print("<<< File loaded - \(Date().timeIntervalSince(startStamp))\n")
    serializeJSON(data: data, completion: { dict in

        print("<<< JSON Serialized - \(Date().timeIntervalSince(startStamp))\n")
        print(dict)
    })
})

print("<<< loadFile call complete - \(Date().timeIntervalSince(startStamp))\n")

let session = URLSession()
var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts/1")!)

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

    if let error = error {
        print(error)
    }

    if let data = data {

        serializeJSON(data: data) { json in
            print(json)
        }
    }

}

print("<<< Start URLSession dataTask - \(Date().timeIntervalSince(startStamp))\n")
task.resume()
print("<<< dataTask call complete - \(Date().timeIntervalSince(startStamp))\n")

PlaygroundPage.current.needsIndefiniteExecution = true
