import tables

# SCOPE
var scope: Table[string, string]

proc insert*(key: string, value: string) =
    scope[key] = value

proc notInScope*(variable: string): bool =
    variable notin scope

proc fetchValue*(variable: string): string =
    scope[variable]


# FUNCTION TABLE
const functionTable = {"reverse" : 1}.toTable

func notInList*(function: string): bool =
    function notin functionTable

func checkArgs*(function: string, argsNum: int): bool =
    functionTable[function] != argsNum

func returnNumOfArgs*(function: string): int =
    functionTable[function]
