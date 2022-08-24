"""
    Maybe{X}

Type shortcut for "`X` or nothing" or "nullable `X`" in javaspeak. Name
Borrowed from https://github.com/LCSB-BioCore/SBML.jl/blob/master/src/types.jl.
"""
const Maybe{X} = Union{X,Nothing}