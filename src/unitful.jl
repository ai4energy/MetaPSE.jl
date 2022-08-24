"""
SI unit definitions

reference:
    Modelica.Units.SI
"""

#= 
const prefixdict = Dict(
    -24 => "y", #yocto
    -21 => "z", #zepto
    -18 => "a", #atto
    -15 => "f", #femto
    -12 => "p", #pico
    -9  => "n", #nano
    -6  => "μ", #micro
    -3  => "m", #milli
    -2  => "c", #centi
    -1  => "d", #deci
    0   => "", #
    1   => "da", #deka
    2   => "h", #hecto
    3   => "k", #kilo
    6   => "M", #mega
    9   => "G", #giga
    12  => "T", #tera
    15  => "P", #peta
    18  => "E", #exa
    21  => "Z", #zetta
    24  => "Y", #yotta
) =#

const BASE_UNIT_STRING = Dict(

#base unit
    "dimensionless" => 1,

    "meter" => 1.0 * u"m",
    "kilogram" => 1.0 * u"kg",
    "second" => 1.0 * u"s",
    "candela" => 1.0 * u"cd",
    "ampere" => 1.0 * u"A",
    "kelvin" => 1.0 * u"K",
    "mole" => 1.0 * u"mol",

# Angles
    "radian" => 1.0 * u"rad",
    "steradian" => 1.0 * u"sr",  

#Mass
    "gram" => 1.0 * u"g",
#Time

#Frequency
    
    "hertz" => 1.0 * u"Hz",


#Length related
#Volumn
#Energy
#Electromagnetism
#Pressure
#Viscosity

#Radioactivity
#Optics
#Catalytic Activity


"newton" => 1.0 * u"N",
    "nounit" => 1, # UNIT_SI_NOUNIT
    "item" => 1, # UNIT_SI_ITEM

    "volt" => 1.0 * u"V", # UNIT_SI_VOLT
    "Celsius" => 1.0 * u"°C", # UNIT_SI_CELSIUS
    "coulomb" => 1.0 * u"C", # UNIT_SI_COULOMB
 # UNIT_SI_HERTZ
    "joule" => 1.0 * u"J", # UNIT_SI_JOULE
    

    "ohm" => 1.0 * u"Ω", # UNIT_SI_OHM
    "pascal" => 1.0 * u"Pa", # UNIT_SI_PASCAL



    "farad" => 1.0 * u"F", # UNIT_SI_FARAD
 # UNIT_SI_GRAM
    "liter" => 1.0 * u"L", # UNIT_SI_LITER
    "watt" => 1.0 * u"W", # UNIT_SI_WATT
    "timeday" => 1.0 * u"d", 
)

"""
单位定义，很多量都有单位。

For example, the unit "per square megahour", Mh^(-2), is written as:

    MetaPSE.Unit("second",  # base SI unit, this says we are measuring time
             -2,        # exponent, says "per square"
             6,         # log-10 scale of the unit, says "mega"
             1/3600)    # second-to-hour multiplier

Compound units (such as "volt-amperes" and "dozens of yards per ounce") are
built from multiple `UnitPart`s.  See also [`SBML.UnitDefinition`](@ref).

# Fields

"""
Base.@kwdef struct PSEUnit
    name::Symbol
    baseunitstring::String #用以从BASE_UNIT_STRING字典里查取基本单位
    exponent::Int
    scale::Int
    multiplier::Float64
    annotation::Maybe{String}
end

const Current=Unit(:Current,"ampere",1,1,1,"amper")
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)
const Current=Unit(:Current,"ampere",1,1,1)

Base.@kwdef struct PSEVariable
    name::Symbol
    unit::Unit #用以从UNITFUL_KIND_STRING字典里查取对应的国际单位制标准单位
    defaultValue::Float64
    MinValue::Float64
    MaxValue::Float64
    """
    mktvar
    """
    mtkvar
end


Base.@kwdef struct PSEParameter
    name::Symbol
    unit::metaPSEUnit #用以从UNITFUL_KIND_STRING字典里查取对应的国际单位制标准单位
    defaultValue::Float64
    MinValue::Float64
    MaxValue::Float64
    """
    mktvar
    """
    mtkvar
end

Base.@kwdef struct PSEquation
    name::Symbol
    unit::metaPSEUnit #用以从UNITFUL_KIND_STRING字典里查取对应的国际单位制标准单位
    defaultValue::Float64
    MinValue::Float64
    MaxValue::Float64
    """
    mktvar
    """
    mtkvar
end
Base.@kwdef struct PSEComponent
    name::Symbol
    unit::metaPSEUnit #用以从UNITFUL_KIND_STRING字典里查取对应的国际单位制标准单位
    defaultValue::Float64
    MinValue::Float64
    MaxValue::Float64
    """
    mktvar
    """
    mtkvar
end



abc=metaPSEUnit(:abc,Current,1.0,0.0,10.0)