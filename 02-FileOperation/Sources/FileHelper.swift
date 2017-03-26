//
//  FileHelper.swift
//  FileOperation
//
//  Created by shanks-tmt on 2017/3/18.
//
//

import Foundation
#if os(Linux)
    import Glibc
#endif


enum FileWriteMode {
    case Write, Append
    
    func cMode() -> String {
        switch self {
        case .Write: return "w+"
        case .Append: return "a+"
        }
    }
}
class FileHelper {
    var filePath: String
    
    init(file: String) {
        self.filePath = file
    }
    func read() -> String {
        do {
            let content = try String(contentsOfFile: self.filePath, encoding: String.Encoding.utf8)
            return content
        } catch {
            return ""
        }
    }
    func write(content: String) {
        self.writeByMode(content: content, writeMode: .Write)
    }
    
    func append(content: String) {
        self.writeByMode(content: content, writeMode: .Append)
    }
    
    private func writeByMode(content: String, writeMode: FileWriteMode){
        
        content.withCString { (ptr: UnsafePointer<Int8>) -> Void in
            let fd = fopen(self.filePath, writeMode.cMode())
            
            if writeMode == .Append {
                fseek(fd, 0, SEEK_END)
            }
            
            fwrite(ptr, 1, content.lengthOfBytes(using: String.Encoding.utf8), fd)
        
            let res = fclose(fd)
            if res != 0 {
                print(strerror(errno))
            }
        }

    }
}
