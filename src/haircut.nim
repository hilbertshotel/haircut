import os
import strutils

import error
import scope
import interpreter
import info


proc print(err: string) =
    stderr.writeLine(err)
    flushFile(stderr)


proc checkFile(filename: string): string =
    # check if file exists
    let isFile = fileExists(filename)
    if not isFile:
        return error.noSuchFile
    
    # check if file extension is valid
    let extension = filename[^4..^1]
    if extension != ".rcu":
        return error.invalidFile

    return "ok"


proc start(filename: string) =
    let fileCheck = checkFile(filename)
    if fileCheck != "ok":
        fileCheck.print 
        return
    
    var 
        lineNum = 0
        mainOut: string

    let input = readLine(stdin)
    scope.insert("input", input)

    for line in filename.lines:        
        lineNum += 1

        if line.isEmptyOrWhitespace: continue
        if line[0] == '#': continue

        let (err, output) = interpreter.start(line, lineNum)
        if err != "ok":
            err.print
            return
        
        mainOut = output

    echo mainOut


proc main() =
    let args = commandLineParams()
    
    case args.len:
    of 0: echo info.show
    of 1: start(args[0])
    else: echo error.tooManyArgs


main()
