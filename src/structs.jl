"""
MetaPSE中量的单位

Part of a measurement unit definition that corresponds to the MetaPSE definition
of `Unit`. For example, the unit "per square megahour", Mh^(-2), is written as:

    MetaPSE.UnitType("second",  # base SI unit, this says we are measuring time
             -2,        # exponent, says "per square"
             6,         # log-10 scale of the unit, says "mega"
             1/3600)    # second-to-hour multiplier

Compound units (such as "volt-amperes" and "dozens of yards per ounce") are
built from multiple `UnitPart`s.  See also [`MetaPSE.UnitDefinition`](@ref).
"""
Base.@kwdef struct UnitType
    name::Symbol
    siUnitString::String #用以从UNITFUL_KIND_STRING字典里查取对应的国际单位制标准单位
    exponent::Int
    scale::Int
    multiplier::Float64
end

#const Current=UnitType(:Current,"ampere",1,1,1)


Base.@kwdef struct VariableType
    name::Symbol
    UnitType::String #用以从UNITFUL_KIND_STRING字典里查取对应的国际单位制标准单位
    defaultValue::Float64
    MinValue::Float64
    MaxValue::Float64
end