#= """
units definitions

reference:
    Modelica.Units
    Deatools Units/units_pool.h
    SBML.jl src/unitful.jl
    gPROMS Unit
"""
 =#
import Unitful
using Unitful: @unit, @u_str
#using Unitful: @derived_dimension, @dimension, @refunit, @u_str, @unit, Quantity, uconvert

# dimensionless
@unit dimless "dimless" dimless 1 * Unitful.NoUnits false

# seven base SI units
@unit meter "meter" meter 1.0 * u"m" false
@unit second "second" second 1 * Unitful.s false
@unit kilogram "kilogram" kilogram 1 * Unitful.kg false
@unit kelvin "kelvin" kelvin 1 * Unitful.K false
@unit ampere "ampere" ampere 1 * Unitful.A false
@unit candela "candela" candela 1 * Unitful.cd false
@unit mole "mol" mole 1 * Unitful.mol false

# Angels

# Mass

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

@unit kilomole_per_cubic_metre "kmol/m^3" kilomole_per_cubic_metre 1.0 * u"kmol/m^3" true


#= const localunits = Unitful.basefactors
function __init__()
    merge!(Unitful.basefactors, localunits)
    Unitful.register(PSEUnits)
end
 =#

