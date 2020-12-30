import strutils

import stdlib
import scope
import error


func isNotValid(variable: string): bool =
    for ch in variable:
        if ch notin 'a'..'z': return true
    return false


proc start*(line: string, lineNum: int): (string, string) =
    if '=' notin line:
        return (error.missingSep(lineNum), "")
    
    # what if '=' is a function argument for filter for example?
    let lineSeq = line.split('=')
    
    if lineSeq.len != 2:
        return (error.tooManySep(lineNum), "")

    let
        variable = lineSeq[0].strip
        fcall = lineSeq[1].strip

    if variable == "input":
        return (error.inputImmutable(lineNum), "")
    if variable.isNotValid:
        return (error.invalidVariable(variable, lineNum), "")

    let 
        fcallSeq = fcall.split
        function = fcallSeq[0].strip
        args = fcallSeq[1..^1]

    if function.notInList:
        return (error.noSuchFunction(function, lineNum), "")
    if checkArgs(function, args.len):
        return (error.functionArgs(function, lineNum), "")

    let (err, output) = callFunction(function, args, lineNum)
    if err != "ok": return (err, "")

    scope.insert(variable, output)

    ("ok", output)
