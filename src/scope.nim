import tables
import strutils


# SCOPE
var scope: Table[string, string]

proc insert*(key: string, value: string) =
    scope[key] = value

proc notInScope*(variable: string): bool =
    variable notin scope

proc fetchValue*(variable: string): string =
    scope[variable]


# FUNCTION TABLE
const functionTable = {"reverse" : 1,
                       "slice" : 3}.toTable

func notInList*(function: string): bool =
    function notin functionTable

func checkArgs*(function: string, argsNum: int): bool =
    functionTable[function] != argsNum

func returnNumOfArgs*(function: string): int =
    functionTable[function]


# UTILITY
func isNotValid*(variable: string): bool =
    for ch in variable:
        if ch notin 'a'..'z': return true
    return false

proc passToStdErr*(err: string) =
    stderr.writeLine(err)
    flushFile(stderr)

func isNotNumber*(str: string): bool =
    try:
        discard str.parseInt
        return false
    except ValueError:
        return true
