import strutils

import stdlib
import scope
import error


proc start*(line: string, lineNum: int): (string, string) =
    if '=' notin line: return error.missingSep(lineNum)
    
    # what if '=' is a function argument for filter for example?
    let lineSeq = line.split('=')
    if lineSeq.len != 2: return error.tooManySep(lineNum)

    let variable = lineSeq[0].strip
    if variable == "input": return error.inputImmutable(lineNum)
    if variable.isNotValid: return error.invalidVar(variable, lineNum)

    let 
        fcall = lineSeq[1].strip.split
        function = fcall[0].strip
        args = fcall[1..^1]

    if function.notInList: return error.noSuchFunc(function, lineNum)
    if checkArgs(function, args.len): return error.funcArgs(function, lineNum)

    let (err, output) = callFunction(function, args, lineNum)
    if err != "ok": return (err, "")

    scope.insert(variable, output)
    return ("ok", output)
