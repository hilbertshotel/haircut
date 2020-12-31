const show* = """Haircut is a string processing protocol for Unix pipelines

Usage:
    input | haircut script.rcu | output

Specification:
    The Haircut ecosystem consists of a lightweight interpreter for .rcu files, a small standard library
    of popular functions and this very concise specification. The purpose of .rcu scripts is to be thrown
    into pipelines whenever string processing is required.

    An .rcu script follows these simple rules: stdin is held in the global immutable variable `input`
    which can be referenced at all times. Each line consists of an assignment. On the left side is
    the variable name (lowercase alphabetic characters only) and on the right side is the function call
    with all its necessary arguments. Variables are mutable for the purpose of reuse. The last assignment
    in the script is quietly passed to stdout. Comments are allowed but only above or bellow assignments.
    
Example script:
    # this is a comment
    x = slice input 3 8
    y = slice input 11 -1
    x = reverse x
    z = concat x y    

Stdlib:
    reverse x    -> reverse a string `x`
    slice x y z  -> slice a string `x` from index `y` to index `z` (inclusive)
    -- work in progress -- 

Misc:
    Haircut supports the shebang line
"""

# write tests