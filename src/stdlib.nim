import strutils

import scope
import error


# REVERSE
proc reverseFunction(args: seq[string], lineNum: int): (string, string) =
    let variable = args[0].strip
    if variable.notInScope: return error.notInScope(variable, lineNum)
    let value = variable.fetchValue
    var output: string
    for i in countdown(value.len-1, 0): output.add(value[i])
    return ("ok", output)


# SLICE
proc sliceFunction(args: seq[string], lineNum: int): (string, string) =
    let variable = args[0].strip
    if variable.notInScope: return error.notInScope(variable, lineNum)  
    
    var
        arg1 = args[1].strip
        arg2 = args[2].strip

    if arg1.isNotNumber: return error.notNumber(arg1, lineNum)
    if arg2.isNotNumber: return error.notNumber(arg2, lineNum)
    
    var 
        output: string
        i1 = arg1.parseInt
        i2 = arg2.parseInt
        
    let value = variable.fetchValue 

    if i1 < 0 and i2 < 0:
        i1 = arg1[1..^1].parseInt
        i2 = arg2[1..^1].parseInt
        try:
            output = value[^i1..^i2]
        except:
            return error.outOfRange(lineNum)

    elif i1 < 0: 
        i1 = arg1[1..^1].parseInt
        try:
            output = value[^i1..i2]
        except:
            return error.outOfRange(lineNum)

    elif i2 < 0:
        i2 = arg2[1..^1].parseInt
        try:
            output = value[i1..^i2]
        except:
            return error.outOfRange(lineNum)

    else:
        try:
            output = value[i1..i2]
        except:
            return error.outOfRange(lineNum)

    return ("ok", output)   


# CONCAT
proc concatFunction(args: seq[string], lineNum: int): (string, string) =
    let var1 = args[0].strip
    if var1.notInScope: return error.notInScope(var1, lineNum)
    let var2 = args[1].strip
    if var2.notInScope: return error.notInScope(var2, lineNum)
    let output = var1.fetchValue & var2.fetchValue
    return ("ok", output)


# MAIN
proc callFunction*(function: string, args: seq[string], lineNum: int): (string, string) =
    if function == "reverse": return reverseFunction(args, lineNum)
    if function == "slice": return sliceFunction(args, lineNum)
    if function == "concat": return concatFunction(args, lineNum)
