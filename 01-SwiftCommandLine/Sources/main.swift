let argCount = CommandLine.argc
let arguments = CommandLine.arguments

print(argCount)

for argument in arguments {
    print(argument)
}

//print(CommandLine.arguments[1])

var point: UnsafeMutablePointer<Int8>?  = CommandLine.unsafeArgv[0]
if let temp = point {
    let str = String(cString: temp)
    print(str)

}

