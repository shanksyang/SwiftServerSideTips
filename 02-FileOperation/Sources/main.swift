import Foundation

#if os(Linux)
    import Glibc
#endif


let argCount = CommandLine.argc
let arguments = CommandLine.arguments

print(argCount)

for argument in arguments {
    print(argument)
}


let filePath = "./data.txt"

let writeString = "春江水暖鸭先知"
do {
    try writeString.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
} catch let error as NSError {
    print("Failed writing to: \(filePath), Error: " + error.localizedDescription)
}

do {
    let fileContents = try String(contentsOfFile: "./data1.txt", encoding: String.Encoding.utf8)
    print(fileContents)
} catch {
    print("Failed writing")
}


let manager = FileManager.default


if let content = manager.contents(atPath: filePath) {
    
    print(String(data: content, encoding: String.Encoding.utf8))
}


let handler = FileHandle(forUpdatingAtPath: filePath)
let string = "添加一些文字到文件末尾"
let appendedData = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
handler?.seekToEndOfFile()
handler?.write(appendedData!)
handler?.seek(toFileOffset: 0) // 需要把文件描述符偏移量重置为0
let data = handler?.readDataToEndOfFile()



let readingHandler = FileHandle(forReadingAtPath: filePath)

guard let data = readingHandler?.readDataToEndOfFile() else {
    exit(0)
}

guard let content = String(data: data, encoding: String.Encoding.utf8) else {
    exit(0)
}
//print(content)
var helper = FileHelper(file: filePath)
print(helper.read())

helper.write(content: "你好")
helper.append(content: "再见")








