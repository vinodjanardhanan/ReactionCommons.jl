module ReactionCommons
using RxnHelperUtils

export parase_rxn_string, parse_rxn_params, get_dependencies, species_rxn_map
export RxnType

@enum RxnType stick=1 arrhenius=2 falloff=3

"""
An anstract type for surface reaction mechanism parameter definitions
"""
abstract type MechanismDefinition end
export MechanismDefinition

abstract type Mechanism end
export Mechanism

abstract type ReactionState end
export ReactionState
"""
composite type for the definition of site definition of a surface reaction mechanism
"""
struct SiteInfo
    name::String    # name of the surface reaction mechanism
    density::Float64    # surface site density in mol/cm2    
    site_coordination::Array{Float64,1} # site coordination of adsorbed species by default 1 for all
    ini_covg::Array{Float64,1} # intitial surface coverage as read from the mechanism
end
export  SiteInfo


mutable struct SurfaceRxnParameters 
    s::Float64  # stickig coefficient
    k0::Float64 # pre-exponential factor cm-mol-s
    β::Float64  # temperature exponent
    E::Float64  # Activation energy in J/mol
end
export  SurfaceRxnParameters

struct SurfaceRxnStoichiometry   
    reversible::Bool    #whether the reaction is reversible or not
    reactant_ids::Array{Int64,1} # id of reactant species participating in an elementary reaction
    product_ids::Array{Int64,1} #id of product species prarticipating in an elementary reaction
    cov_dep::Dict{Int64,Float64} #coverage dependency of the reaction: species_id=>cov dependent activation energy   
    order_dep::Dict{Int64,Float64} #order dependency of the reaction: species_id=>order w.r.t the species
end
export SurfaceRxnStoichiometry


struct SurfaceReaction
    id::Int64 #reaction number
    type::RxnType #reaction type stick or arrhenius
    params::SurfaceRxnParameters #composite type Parameters
    mwc::Bool #whether MWC is applied or not      
    rxn_stoic::SurfaceRxnStoichiometry #composite type Stoichiometry
end
export SurfaceReaction

struct SurfaceMechanism <: Mechanism
    energy_factor::Float64 # Conversion factor for activation energy to SI units
    si::SiteInfo # Composite type SiteInfo
    species::Array{String,1} #list of surface species present in the mechanism
    reactions::Array{SurfaceReaction,1} #Array of composite type ElementaryReactions
end
export SurfaceMechanism

struct SpeciesRxnMap 
    species_id::Int64 #id of the species
    rxns::Array{Int64,1}    #id of reactions in which the species participates
    stoic_coeff::Array{Int64,1} #stoichiometric coefficient of the species in the reaction
end
export SpeciesRxnMap

struct SurfaceMechDefinition <: MechanismDefinition 
    sm::SurfaceMechanism
    srm_array::Array{SpeciesRxnMap,1}
end
export SurfaceMechDefinition


mutable struct SurfaceRxnState <: ReactionState
    T::Float64
    p::Float64 
    mole_frac::Array{Float64,1}
    covg::Array{Float64,1}    
    surf_conc::Array{Float64,1} # concentration of surface species
    rxn_rate::Array{Float64,1}    # rate of individual reactions 
    source::Array{Float64,1}    # source terms for species production/consumption
    all_conc::Array{Float64,1}  # concentration of all species 
end 
export SurfaceRxnState


"""
The following definitions are for gasphase reactions
"""

"""
Arrhenius reaction rate parameters
"""
mutable struct Arrhenius     
    k0::Float64 # pre-exponential factor cm-mol-s
    β::Float64  # temperature exponent
    E::Float64  # Activation energy in J/mol 
end
export Arrhenius



"""
Parameters for troe reaction parameters 
"""
struct Troe    
    a::Float64 
    T3star::Float64 
    Tstar::Float64 
    T2star::Float64 
end
export Troe

"""
Parameters for Sri reaction parameters
"""
struct Sri 
    a::Float64 
    b::Float64 
    c::Float64 
    d::Float64
    e::Float64 
end
export Sri

struct LandauTeller 
    b::Float64
    c::Float64
end
export LandauTeller

"""
Stoichiometry object for gasphase reactions for an individual reaction 
"""
struct GasphaseRxnStoichiometry 
    reversible::Bool    #whether the reaction is reversible or not
    reactant_ids::Array{Int64,1} # id of reactant species participating in an elementary reaction
    product_ids::Array{Int64,1} #id of product species prarticipating in an elementary reaction
    st_eq::AbstractString # Stoichiometric Equation
end
export GasphaseRxnStoichiometry 


"""
Object defining an elementary gasphase reaction 
"""
struct GasphaseReaction 
    id::Int # reaction id 
    fall_off::Bool
    third_body::Bool    
    third_body_species::String
    params::Arrhenius # Arrhenius parameters
    rxn_stoic::GasphaseRxnStoichiometry # GasphaseRxnStoichiometry
end
export GasphaseReaction



mutable struct GasphaseState <: ReactionState
    T::Float64 # temperature in K 
    p::Float64 # Pressure in Pa 
    mole_frac::Array{Float64,1} # gasphase species mole fractions     
    conc::Array{Float64,1} # mutating array for storing the full concentration 
    g_rxn_rate::Array{Float64,1} # mutating individual gasphase reaction rates
    source::Array{Float64,1}   # source term of individual species due to gas phase reactions 
    g_all::Array{Float64,1} # Memory space for calculation of Gibbs free energy of individual species 
    Kp::Array{Float64,1} # Memory stapce for calculation of Equilibrim constant 
end
export GasphaseState


"""
Object for defining order of a reaction using FORD or RORD keyword for gasphase reactions 
"""
struct Order 
    α::Dict{Int64,Float64}
end

"""
Auxiliary reaction data for gasphase kinetics 
"""
struct AuxiliaryData 
    third_body_reaction::Dict{Int64, Dict{Int64,Float64}}
    low_reactions::Dict{Int64,Arrhenius}
    troe_reactions::Dict{Int64,Troe}
    high_reactions::Dict{Int64,Arrhenius}
    sri_reactions::Dict{Int64,Sri}    
    rev_reactions::Dict{Int64,Arrhenius}
    lt_reactions::Dict{Int64, LandauTeller}
    f_order::Dict{Int64,Dict{Int64,Float64}}
    r_order::Dict{Int64,Dict{Int64,Float64}}
end
export AuxiliaryData


"""
Object defining the gasphase reaction mechanism 
"""
struct GasphaseMechanism <: Mechanism
    species::Array{String,1} #list of species present in the mechanism
    reactions::Array{GasphaseReaction,1} #Array of composite type Elementary gasphase reactions  
    aux_data::AuxiliaryData
end
export GasphaseMechanism

struct GasMechDefinition <: MechanismDefinition
    gm::GasphaseMechanism
    rxn_species_array::Array{SpeciesRxnMap,1}
end
export GasMechDefinition


struct Chemistry 
    surfchem::Bool    
    gaschem::Bool    
    userchem::Bool
    udf::Function
end
export Chemistry


"""
Separate the reactants and products from the stoichiometric equation
#   Usage:
    parase_rxn_string(rxn_str)
-   rxn_str::String:    String representing the reaction equation
"""
function parse_rxn_string(rxn_str::String)
    #check whether the reaction is reversible
    reversible = false
    m = match(r"<=>|=>|=|>",rxn_str)
    if m.match == "=" || m.match == "<=>"
        reversible = true
    end
    species = collect(split(rxn_str,m.match))    
    r_species = [String(strip(uppercase(i))) for i in split(species[1],"+")]
    p_species = [String(strip(uppercase(i))) for i in split(species[2],"+")]    
    return (reversible,r_species,p_species)
end
export parse_rxn_string

function parse_rxn_params(params::String)
    k = β = E = 0.0
    all_params = split(params)
    k = parse(Float64,all_params[1])
    if length(all_params) == 3
        β = parse(Float64,all_params[2])
        E = parse(Float64,all_params[3])
    elseif length(all_params)==2
        E = parse(Float64,all_params[2])
    end
    return k, β, E
end
export parse_rxn_params

"""
Function to determine the coverage dependency, order dependency and MWC
for a reaction
#   Usage
    get_dependencies(cov_dep_rxns,order_dep_rxns,mwc_rxns,rxn_id)
-   cov_dep_rxns::Dict{Int64=>Dict{Int64=>Float64}}
-   order_dep_rxns::Dict{Int64=>Dict{Int64=>Float64}}
-   mwc_rxns::Array{Int64}
-   rxn_id::Int64
The function returns a tuple of cov,order and mwc
"""
function get_dependencies(cov_dep_rxns,order_dep_rxns,mwc_rxns,rxn_id)
    #Check for coverage dependency
    cov = Dict{Int64,Float64}()
    ord = Dict{Int64,Float64}()
    if haskey(cov_dep_rxns,rxn_id)
        cov = cov_dep_rxns[rxn_id]
    end
    #Check for order dependency
    if haskey(order_dep_rxns,rxn_id)
        ord = order_dep_rxns[rxn_id]
    end
    #Check for mwc
    mwc = in(rxn_id,mwc_rxns)
    return cov,ord,mwc

end

"""
Create array of structures of SpeciesRxnMap. The SpeciesRxnMap is a 
composit structure of species_id in participating reactions and the
stoichiometric coefficients
#   Usage
    species_rxn_map(gas_species,sm)
-   gas_species::Array{String,1} :  list of gas phase species
-   sm::SurfaceMechanism : SurfaceMechanism composite type
"""
function species_rxn_map(gas_species::Array{String,1},mech::Mechanism)
    #Array of SpeciesRxnMap
    srm_array = Array{SpeciesRxnMap,1}()
    #create list of all species
    all_species = Array{String,1}()
    all_species = copy(gas_species)
    append!(all_species,mech.species)
    #loop over all species
    for sp in all_species
        sp_id = get_index(sp,all_species)
        #check if the species is present in the reactant_ids of a reaction
        rxns = Array{Int64,1}()
        stc = Array{Int64,1}()
        for rxn in mech.reactions
            #count the number of occurances of species in reactants list (using ids)
            n = count(x->x==sp_id,rxn.rxn_stoic.reactant_ids)
            if n > 0
                push!(rxns,rxn.id)
                push!(stc,-n)
            end            
            #count the number of occurances of species in the products list (using ids)
            n = count(x->x==sp_id,rxn.rxn_stoic.product_ids)
            if n > 0
                push!(rxns,rxn.id)
                push!(stc,n)
            end
        end
        push!(srm_array,SpeciesRxnMap(sp_id,rxns,stc))
    end
    return srm_array
end


# end of module
end
