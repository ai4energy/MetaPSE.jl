"""
units definitions

reference:
    Modelica.Units
"""
module PSEUnit
import Unitful
using Unitful: @unit



end


@unit AU         "AU"       AstronomicalUnit          149_597_870_700.0*m       false

@unit sft_us      "ftˢ"       USSurveyFoot      12sinch_us              false
@unit sli_us      "liˢ"       USSurveyLink      (33//50)sft_us          false
@unit syd_us      "ydˢ"       USSurveyYard      3sft_us                 false
@unit srd_us      "rdˢ"       USSurveyRod       25sli_us                false
@unit sch_us      "chˢ"       USSurveyChain     4srd_us                 false
@unit sfur_us     "furˢ"      USSurveyFurlong   10sch_us                false
@unit smi_us      "miˢ"       USSurveyMile      8sfur_us                false
@unit slea_us     "leaˢ"      USSurveyLeague    3smi_us                 false

# Survey areas
@unit sac_us      "acˢ"       USSurveyAcre      43560sft_us^2           false
@unit town_us     "township"  USSurveyTownship  36smi_us^2              false

# Dry volumes
# Exact but the fraction is awful; will fix later
@unit drypt_us    "dryptᵘˢ"   USDryPint   550.6104713575*Unitful.ml     false
@unit dryqt_us    "dryqtᵘˢ"   USDryQuart        2drypt_us               false
@unit pk_us       "pkᵘˢ"      USPeck            8dryqt_us               false
@unit bushel_us   "buᵘˢ"      USBushel          4pk_us                  false

# Liquid volumes
@unit gal_us      "galᵘˢ"     USGallon          231*(Unitful.inch)^3    false
@unit qt_us       "qtᵘˢ"      USQuart           gal_us//4               false
@unit pt_us       "ptᵘˢ"      USPint            qt_us//2                false
@unit cup_us      "cupᵘˢ"     USCup             pt_us//2                false
@unit gill_us     "gillᵘˢ"    USGill            cup_us//2               false
@unit floz_us     "fl ozᵘˢ"   USFluidOunce      pt_us//16               false
@unit tbsp_us     "tbspᵘˢ"    USTablespoon      floz_us//2              false
@unit tsp_us      "tspᵘˢ"     USTeaspoon        tbsp_us//3              false
@unit fldr_us     "fl drᵘˢ"   USFluidDram       floz_us//8              false
@unit minim_us    "minimᵘˢ"   USMinim           fldr_us//60             false
const localunits = Unitful.basefactors
function __init__()
    merge!(Unitful.basefactors, localunits)
    Unitful.register(UnitfulUS)
end
const Angle=PSEUnit(:Angle,"radian",1,1,1,"radian")
const SolidAngle=PSEUnit(:SolidAngle,"steradian",1,1,1,"steradian")
const Length=PSEUnit(:Length,"meter",1,1,1,"meter")
const PathLength=PSEUnit(:PathLength,"meter",1,1,1,"meter")
const Position=PSEUnit(:Position,"meter",1,1,1,"meter")
const Distance=PSEUnit(:Distance,"meter",1,1,1,"meter")
const Breadth=PSEUnit(:Breadth,"meter",1,1,1,"meter")
const Height=PSEUnit(:Height,"meter",1,1,1,"meter")
const Thickness=PSEUnit(:Thickness,"meter",1,1,1,"meter")
const Radius=PSEUnit(:Radius,"meter",1,1,1,"meter")
const Diameter=PSEUnit(:Diameter,"meter",1,1,1,"meter")
const Area=PSEUnit(:Area,"meter",2,1,1,"m^2")
const Volume=PSEUnit(:Volume,"meter",3,1,1,"m^3")



const BASE_UNIT= Dict(

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
    baseunitstring::String #用以从BASE_UNIT字典里查取基本单位
    exponent::Int
    scale::Int
    multiplier::Float64
    annotation::Maybe{String}
end


