import strutils

import scope
import error


proc reverseFunction(variable: string, lineNum: int): (string, string) =
    if variable.notInScope:
        return (error.notInScope(variable, lineNum), "")

    let value = variable.fetchValue
    
    var output: string
    for i in countdown(value.len-1, 0):
        output.add(value[i])
    
    return ("ok", output)


proc callFunction*(function: string, args: seq[string], lineNum: int): (string, string) =

    if function == "reverse":
        let arg = args[0].strip
        return reverseFunction(arg, lineNum)
    
    # check for type sanity in each function call

    ("ok", "")