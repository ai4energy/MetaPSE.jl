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



######################################################
#https://discourse.julialang.org/t/implementing-singleton-design-pattern/61704/3
######################################################
mutable struct Repository
    x::Int
    y::Int
    rep


   function Repository(x,y)
      # may need atomic access or a lock to make writing threadsafe
      if !isdefind(REPOSITORY, 1) 
          REPOSITORY[] = new(x,y,[0])
      end
      REPOSITORY[]
   end
end
const REPOSITORY = Base.RefValue{Repository}()


######################################################