import strformat
import scope

const err = "\x1B[31m\x1B[1merror:\x1B[0m\x1B[1m"
const close = "\x1B[0m"

const tooManyArgs* = &"{err} Haircut takes only one argument{close}"
const invalidFile* = &"{err} target file is not a valid .rcu file{close}"
const noSuchFile* = &"{err} target file not found{close}"

func missingSep*(lineNum: int): string =
    &"{err} line {lineNum}: missing separator `=`{close}"

func tooManySep*(lineNum: int): string =
    &"{err} line {lineNum}: too many separators `=`{close}"

func inputImmutable*(lineNum: int): string =
    &"{err} line {lineNum}: can't assign to `input`: variable is immutable{close}"

func invalidVariable*(variable: string, lineNum: int): string =
    &"{err} line {lineNum}: variable `{variable}` must contain only lower case alphabetic characters{close}"

func noSuchFunction*(function: string, lineNum: int): string =
    &"{err} line {lineNum}: no such function `{function}` in the standard library{close}"

func functionArgs*(function: string, lineNum: int): string =
    let numOfArgs = scope.returnNumOfArgs(function)
    let args = if numOfArgs > 1: "arguments" else: "argument"
    &"{err} line {lineNum}: function `{function}` takes {numOfArgs} {args}{close}"

func notInScope*(variable: string, lineNum: int): string =
    &"{err} line {lineNum}: variable `{variable}` not in scope{close}"
