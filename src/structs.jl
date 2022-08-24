using .PSEUnits
using Unitful

Base.@kwdef struct PSEVariable
    name::Symbol
    unit::Unitful.FreeUnits #就是只能使用我们定义好的那些unit，如何来check？
    defaultvalue::Float64
    lowerbound::Float64
    upperbound::Float64
    initialgues::Float64
    #constraint要不要？
    #mktvarsym
end

abc=PSEVariable(:abc,PSEUnits.kilomole_per_cubic_metre,1.0, 0.0, 5.0, 2.0)

