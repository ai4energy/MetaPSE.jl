using .PSEUnits
using Unitful

Base.@kwdef struct PSEVariable
    name::Symbol
    unit::Unitful.FreeUnits
    defaultValue::Float64
    MinValue::Float64
    MaxValue::Float64
end

abc=PSEVariable(:abc,PSEUnits.kilomole_per_cubic_metre,1.0, 0.0, 5.0)