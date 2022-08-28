# 
# units definitions

# reference:
#     Modelica.Units
#     Deatools Units/units_pool.h
#     SBML.jl src/unitful.jl
#     gPROMS Unit
# 
import Unitful
using Unitful: @unit, @u_str
using Unitful: @derived_dimension, @dimension, @refunit, Quantity, uconvert

using Unitful: m,s,g,K,A,cd,mol
using Unitful: sr,rad,°
# 
#把要用得到的，在Unitful包中定义了的单位都using上
#using Unitful: Hz,N,Pa,J,W,C,V,Ω


export MetaPSE_UNIT_STRING

######################### Dimensionless ########################################
@unit dimless       "dimless"       DimLess         1.0          false

# 使用这样的方式再定义一些在gPROMS中和modelica中用到的单位。可以查Unitful手册，参考UnitfulUS等包

@unit kilomole_per_cubic_metre "kmol/m^3" kilomole_per_cubic_metre 1.0 * u"kmol/m^3" true

######################### Angle units ##########################################


######################### Mass units ###########################################

# Time

# Frequency

# Length related

# Volume

# Energy

# Electromagnetism

# Pressure

# Viscosity

# Radioactivity

# Optics

# 把单位表做成字典备用，参考gPROMS，SBML.jl


 """
 MetaPSE_UNIT_STRING
 """
 const MetaPSE_UNIT_STRING = Dict(
     "radian" => 1.0 * u"rad", # UNITS_SI_RADIAN
     "steradian" => 1.0 * u"sr", # UNITS_SI_steradian    
     "meter" => 1.0 * u"m", # UNIT_SI_METRE
 
     "second" => 1.0 * u"s", # UNIT_SI_SECOND
     "kilogram" => 1.0 * u"kg", # UNIT_SI_KILOGRAM
     "kelvin" => 1.0 * u"K", # UNIT_SI_KELVIN
     "ampere" => 1.0 * u"A", # UNIT_SI_AMPERE
     "candela" => 1.0 * u"cd", # UNIT_SI_CANDELA
     "mole" => 1.0 * u"mol", # UNIT_SI_MOLE
 
     "dimensionless" => 1, # UNIT_SI_DIMENSIONLESS
     "nounit" => 1, # UNIT_SI_NOUNIT
     "item" => 1, # UNIT_SI_ITEM
 
     "volt" => 1.0 * u"V", # UNIT_SI_VOLT
     "Celsius" => 1.0 * u"°C", # UNIT_SI_CELSIUS
     "coulomb" => 1.0 * u"C", # UNIT_SI_COULOMB
     "hertz" => 1.0 * u"Hz", # UNIT_SI_HERTZ
     "joule" => 1.0 * u"J", # UNIT_SI_JOULE
     
     "newton" => 1.0 * u"N", # UNIT_SI_NEWTON
     "ohm" => 1.0 * u"Ω", # UNIT_SI_OHM
     "pascal" => 1.0 * u"Pa", # UNIT_SI_PASCAL
     "radian" => 1.0 * u"rad", # UNIT_SI_RADIAN
 
     "farad" => 1.0 * u"F", # UNIT_SI_FARAD
     "gram" => 1.0 * u"g", # UNIT_SI_GRAM
     "liter" => 1.0 * u"L", # UNIT_SI_LITER
     "watt" => 1.0 * u"W", # UNIT_SI_WATT
 )