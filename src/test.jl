
"""
$(TYPEDEF)

Representation of SBML unit definition, holding the name of the unit and a
vector of [`SBML.UnitPart`](@ref)s.  See the definition of field `units` in
[`SBML.Model`](@ref).

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct UnitDefinition
    name::Maybe{String} = nothing
    unit_parts::Vector{UnitPart}
end



DECLARE TYPE # gML Utilities Interface:energy_rate_kJ_per_s_gML
    energy_rate_kJ_per_s_gML = 1.0 : -1.0E50 : 1.0E50 unit = "kJ/s"
END




# NOTE: this mapping is valid for Level 3/Version 2, it *may* not be valid for
# other versions.  See
# https://github.com/sbmlteam/libsbml/blob/d4bc12abc4e72e451a0a0f2be4b0b6101ac94160/src/sbml/UnitKind.c#L46-L85
const UNITFUL_KIND_STRING = Dict(
    "ampere" => 1.0 * u"A", # UNIT_KIND_AMPERE
    "avogadro" => ustrip(u"mol^-1", Unitful.Na), # UNIT_KIND_AVOGADRO
    "becquerel" => 1.0 * u"Bq", # UNIT_KIND_BECQUEREL
    "candela" => 1.0 * u"cd", # UNIT_KIND_CANDELA
    "Celsius" => 1.0 * u"°C", # UNIT_KIND_CELSIUS
    "coulomb" => 1.0 * u"C", # UNIT_KIND_COULOMB
    "dimensionless" => 1, # UNIT_KIND_DIMENSIONLESS
    "farad" => 1.0 * u"F", # UNIT_KIND_FARAD
    "gram" => 1.0 * u"g", # UNIT_KIND_GRAM
    "gray" => 1.0 * u"Gy", # UNIT_KIND_GRAY
    "henry" => 1.0 * u"H", # UNIT_KIND_HENRY
    "hertz" => 1.0 * u"Hz", # UNIT_KIND_HERTZ
    "item" => 1, # UNIT_KIND_ITEM
    "joule" => 1.0 * u"J", # UNIT_KIND_JOULE
    "katal" => 1.0 * u"kat", # UNIT_KIND_KATAL
    "kelvin" => 1.0 * u"K", # UNIT_KIND_KELVIN
    "kilogram" => 1.0 * u"kg", # UNIT_KIND_KILOGRAM
    "liter" => 1.0 * u"L", # UNIT_KIND_LITER
    "litre" => 1.0 * u"L", # UNIT_KIND_LITRE
    "lumen" => 1.0 * u"lm", # UNIT_KIND_LUMEN
    "lux" => 1.0 * u"lx", # UNIT_KIND_LUX
    "meter" => 1.0 * u"m", # UNIT_KIND_METER
    "metre" => 1.0 * u"m", # UNIT_KIND_METRE
    "mole" => 1.0 * u"mol", # UNIT_KIND_MOLE
    "newton" => 1.0 * u"N", # UNIT_KIND_NEWTON
    "ohm" => 1.0 * u"Ω", # UNIT_KIND_OHM
    "pascal" => 1.0 * u"Pa", # UNIT_KIND_PASCAL
    "radian" => 1.0 * u"rad", # UNIT_KIND_RADIAN
    "second" => 1.0 * u"s", # UNIT_KIND_SECOND
    "siemens" => 1.0 * u"S", # UNIT_KIND_SIEMENS
    "sievert" => 1.0 * u"Sv", # UNIT_KIND_SIEVERT
    "steradian" => 1.0 * u"sr", # UNIT_KIND_STERADIAN
    "tesla" => 1.0 * u"T", # UNIT_KIND_TESLA
    "volt" => 1.0 * u"V", # UNIT_KIND_VOLT
    "watt" => 1.0 * u"W", # UNIT_KIND_WATT
    "weber" => 1.0 * u"W", # UNIT_KIND_WEBER
    "(Invalid UnitKind)" => 1, # UNIT_KIND_INVALID (let's treat is as a dimensionless quantity)
)



"""
$(TYPEDSIGNATURES)

Converts an SBML unit definition (i.e., its vector of [`UnitPart`](@ref)s) to a
corresponding Unitful unit.
"""
unitful(u::UnitDefinition) = unitful(u.unit_parts)

"""
$(TYPEDSIGNATURES)

Converts a [`UnitPart`](@ref) to a corresponding Unitful unit.

The conversion is done according to the formula from
[SBML L3v2 core manual release 2](http://sbml.org/Special/specifications/sbml-level-3/version-2/core/release-2/sbml-level-3-version-2-release-2-core.pdf)(section 4.4.2).
"""
unitful(u::UnitPart) =
    (u.multiplier * UNITFUL_KIND_STRING[u.kind] * exp10(u.scale))^u.exponent

"""
$(TYPEDSIGNATURES)

Converts an SBML unit (i.e., a vector of [`UnitPart`](@ref)s) to a corresponding
Unitful unit.
"""
unitful(u::Vector{UnitPart}) = prod(unitful.(u))

"""
$(TYPEDSIGNATURES)

Computes a properly unitful value from a value-unit pair stored in the model
`m`.
"""
unitful(m::Model, val::Tuple{Float64,String}) = unitful(m.units[val[2]]) * val[1]

"""
$(TYPEDSIGNATURES)

Overload of [`unitful`](@ref) that uses the `default_unit` if the unit is not
found in the model.

# Example
```
julia> SBML.unitful(mdl, (10.0,"firkin"), 90 * u"lb")
990.0 lb
```
"""
unitful(m::Model, val::Tuple{Float64,String}, default_unit::Number) =
    mayfirst(maylift(unitful, get(m.units, val[2], nothing)), default_unit) * val[1]

"""
$(TYPEDSIGNATURES)

Overload of [`unitful`](@ref) that allows specification of the `default_unit` by
string ID.
"""
unitful(m::Model, val::Tuple{Float64,String}, default_unit::String) =
    unitful(m, val, unitful(m.units[default_unit]))






# name
# version?
# quantity type
# unit
# default value
# lower_bound
# upper_bound





<VariableTypeEntity name="energy_rate_kJ_per_s_gML" version="2">

<DefaultValue>1.0</DefaultValue>
<MinValue>-1.0E50</MinValue>
<MaxValue>1.0E50</MaxValue>
<UomRef name="kilojoule_per_second"/>
</VariableTypeEntity>



"""
A simplified representation of MathML-specified math AST
"""
abstract type Math end

"""
$(TYPEDEF)

A literal value (usually a numeric constant) in mathematical expression

# Fields
$(TYPEDFIELDS)
"""
struct MathVal{T} <: Math where {T}
    val::T
end

"""
$(TYPEDEF)

An identifier (usually a variable name) in mathematical expression

# Fields
$(TYPEDFIELDS)
"""
struct MathIdent <: Math
    id::String
end

"""
$(TYPEDEF)

A constant identified by name (usually something like `pi`, `e` or `true`) in
mathematical expression

# Fields
$(TYPEDFIELDS)
"""
struct MathConst <: Math
    id::String
end

"""
$(TYPEDEF)

A special value representing the current time of the simulation, with a special
name.

# Fields
$(TYPEDFIELDS)
"""
struct MathTime <: Math
    id::String
end

"""
$(TYPEDEF)

Function application ("call by name", no tricks allowed) in mathematical expression

# Fields
$(TYPEDFIELDS)
"""
struct MathApply <: Math
    fn::String
    args::Vector{Math}
end

"""
$(TYPEDEF)

Function definition (aka "lambda") in mathematical expression

# Fields
$(TYPEDFIELDS)
"""
struct MathLambda <: Math
    args::Vector{String}
    body::Math
end

"""
$(TYPEDEF)

Representation of SBML Parameter structure, holding a value annotated with
units and constantness information.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Parameter
    name::Maybe{String} = nothing
    value::Maybe{Float64} = nothing
    units::Maybe{String} = nothing
    constant::Maybe{Bool} = nothing
end

"""
$(TYPEDEF)

SBML Compartment with sizing information.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Compartment
    name::Maybe{String} = nothing
    constant::Maybe{Bool} = nothing
    spatial_dimensions::Maybe{Int} = nothing
    size::Maybe{Float64} = nothing
    units::Maybe{String} = nothing
    notes::Maybe{String} = nothing
    annotation::Maybe{String} = nothing
end

"""
$(TYPEDEF)

SBML SpeciesReference.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct SpeciesReference
    id::Maybe{String} = nothing
    species::String
    stoichiometry::Maybe{Float64} = nothing
    constant::Maybe{Bool} = nothing
end

"""
$(TYPEDEF)

Reaction with stoichiometry that assigns reactants and products their relative
consumption/production rates, lower/upper bounds (in tuples `lb` and `ub`, with
unit names), and objective coefficient (`oc`). Also may contains `notes` and
`annotation`.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Reaction
    name::Maybe{String} = nothing
    reactants::Vector{SpeciesReference} = []
    products::Vector{SpeciesReference} = []
    kinetic_parameters::Dict{String,Parameter} = Dict()
    lower_bound::Maybe{String} = nothing
    upper_bound::Maybe{String} = nothing
    gene_product_association::Maybe{GeneProductAssociation} = nothing
    kinetic_math::Maybe{Math} = nothing
    reversible::Bool
    metaid::Maybe{String} = nothing
    notes::Maybe{String} = nothing
    annotation::Maybe{String} = nothing
end

"""
$(TYPEDEF)

Abstract type representing SBML rules.
"""
abstract type Rule end

"""
$(TYPEDEF)

SBML algebraic rule.

# Fields
$(TYPEDFIELDS)
"""
struct AlgebraicRule <: Rule
    math::Math
end

"""
$(TYPEDEF)

SBML assignment rule.

# Fields
$(TYPEDFIELDS)
"""
struct AssignmentRule <: Rule
    variable::String
    math::Math
end

"""
$(TYPEDEF)

SBML rate rule.

# Fields
$(TYPEDFIELDS)
"""
struct RateRule <: Rule
    variable::String
    math::Math
end

"""
$(TYPEDEF)

SBML constraint.

# Fields
$(TYPEDFIELDS)
"""
struct Constraint
    math::Math
    message::String
end

"""
$(TYPEDEF)

Species metadata -- contains a human-readable `name`, a `compartment`
identifier, `formula`, `charge`, and additional `notes` and `annotation`.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Species
    name::Maybe{String} = nothing
    compartment::String
    boundary_condition::Maybe{Bool} = nothing
    formula::Maybe{String} = nothing
    charge::Maybe{Int} = nothing
    initial_amount::Maybe{Float64} = nothing
    initial_concentration::Maybe{Float64} = nothing
    substance_units::Maybe{String} = nothing
    only_substance_units::Maybe{Bool} = nothing
    constant::Maybe{Bool} = nothing
    metaid::Maybe{String} = nothing
    notes::Maybe{String} = nothing
    annotation::Maybe{String} = nothing
end

"""
$(TYPEDEF)

Gene product metadata.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct GeneProduct
    label::String
    name::Maybe{String} = nothing
    metaid::Maybe{String} = nothing
    notes::Maybe{String} = nothing
    annotation::Maybe{String} = nothing
end

"""
$(TYPEDEF)

Custom function definition.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct FunctionDefinition
    name::Maybe{String} = nothing
    body::Maybe{Math} = nothing
    notes::Maybe{String} = nothing
    annotation::Maybe{String} = nothing
end

"""
$(TYPEDEF)

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct EventAssignment
    variable::String
    math::Maybe{Math} = nothing
end

"""
$(TYPEDEF)

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Trigger
    persistent::Bool
    initial_value::Bool
    math::Maybe{Math} = nothing
end

"""
$(TYPEDEF)

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Objective
    type::String
    flux_objectives::Dict{String,Float64} = Dict()
end

"""
$(TYPEDEF)

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Event
    use_values_from_trigger_time::Cint
    name::Maybe{String} = nothing
    trigger::Maybe{Trigger} = nothing
    event_assignments::Maybe{Vector{EventAssignment}} = nothing
end

"""
$(TYPEDEF)

Structure that collects the model-related data. Contains `parameters`, `units`,
`compartments`, `species` and `reactions` and `gene_products`, and additional
`notes` and `annotation` (also present internally in some of the data fields).
The contained dictionaries are indexed by identifiers of the corresponding
objects.

# Fields
$(TYPEDFIELDS)
"""
Base.@kwdef struct Model
    parameters::Dict{String,Parameter} = Dict()
    units::Dict{String,UnitDefinition} = Dict()
    compartments::Dict{String,Compartment} = Dict()
    species::Dict{String,Species} = Dict()
    initial_assignments::Dict{String,Math} = Dict()
    rules::Vector{Rule} = Rule[]
    constraints::Vector{Constraint} = Constraint[]
    reactions::Dict{String,Reaction} = Dict()
    objectives::Dict{String,Objective} = Dict()
    active_objective::String = ""
    gene_products::Dict{String,GeneProduct} = Dict()
    function_definitions::Dict{String,FunctionDefinition} = Dict()
    events::Dict{String,Event} = Dict()
    name::Maybe{String} = nothing
    id::Maybe{String} = nothing
    metaid::Maybe{String} = nothing
    conversion_factor::Maybe{String} = nothing
    area_units::Maybe{String} = nothing
    extent_units::Maybe{String} = nothing
    length_units::Maybe{String} = nothing
    substance_units::Maybe{String} = nothing
    time_units::Maybe{String} = nothing
    volume_units::Maybe{String} = nothing
    notes::Maybe{String} = nothing
    annotation::Maybe{String} = nothing
end


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
Base.@kwdef struct PSEVariable
    name::Symbol
    unit::PSEUnit
    defaultValue::Float64
    MinValue::Float64
    MaxValue::Float64
#=     """
    mktvar
    """
    mtkvar =#
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

