import strformat
import scope

const err = "\x1B[31m\x1B[1merror:\x1B[0m\x1B[1m"
const close = "\x1B[0m"

const tooManyArgs* = &"{err} Haircut takes only one argument{close}"
const invalidFile* = &"{err} target file is not a valid .rcu file{close}"
const noSuchFile* = &"{err} target file not found{close}"

func missingSep*(lineNum: int): (string, string) =
    let err = &"{err} line {lineNum}: missing separator `=`{close}"
    return (err, "")

func tooManySep*(lineNum: int): (string, string) =
    let err = &"{err} line {lineNum}: too many separators `=`{close}"
    return (err, "")

func inputImmutable*(lineNum: int): (string, string) =
    let err =  &"{err} line {lineNum}: can't assign to `input`: variable is immutable{close}"
    return (err, "")

func invalidVar*(variable: string, lineNum: int): (string, string) =
    let err = &"{err} line {lineNum}: variable `{variable}` must contain only lower case alphabetic characters{close}"
    return (err, "")

func noSuchFunc*(function: string, lineNum: int): (string, string) =
    let err = &"{err} line {lineNum}: no such function `{function}` in the standard library{close}"
    return (err, "")

func funcArgs*(function: string, lineNum: int): (string, string) =
    let
        numOfArgs = scope.returnNumOfArgs(function)
        args = if numOfArgs > 1: "arguments" else: "argument"
        err = &"{err} line {lineNum}: function `{function}` takes {numOfArgs} {args}{close}"
    return (err, "")

func notInScope*(variable: string, lineNum: int): (string, string) =
    let err = &"{err} line {lineNum}: variable `{variable}` not in scope{close}"
    return (err, "")

func notNumber*(arg: string, lineNum: int): (string, string) =
    let err = &"{err} line {lineNum}: argument `{arg}` must be an integer{close}"
    return (err, "")

func outOfRange*(lineNum: int): (string, string) =
    let err = &"{err} line {lineNum}: index out of range{close}"
    return (err, "")
