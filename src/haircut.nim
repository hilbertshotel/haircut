import os
import strutils

import error
import scope
import interpreter
import info


proc checkFile(filename: string): string =
    if not fileExists(filename): return error.noSuchFile
    if filename.len < 5: return error.invalidFile
    if filename[^4..^1] != ".rcu": return error.invalidFile
    return "ok"


proc start(filename: string) =
    let fileCheck = checkFile(filename)
    if fileCheck != "ok":
        fileCheck.passToStdErr
        return
    
    var lineNum = 0
    var mainOut: string

    let input = readLine(stdin)
    scope.insert("input", input)

    for line in filename.lines:        
        lineNum += 1
        if line.isEmptyOrWhitespace: continue
        if line.strip[0] == '#': continue

        let (err, output) = interpreter.start(line, lineNum)
        if err != "ok":
            err.passToStdErr
            return

        mainOut = output

    echo mainOut


proc main() =
    let args = commandLineParams()
    
    case args.len:
    of 0: echo info.show
    of 1: start(args[0])
    else: error.tooManyArgs.passToStdErr


main()
