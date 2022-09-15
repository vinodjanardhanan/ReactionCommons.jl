var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = ReactionCommons","category":"page"},{"location":"#ReactionCommons","page":"Home","title":"ReactionCommons","text":"","category":"section"},{"location":"#This-package-is-part-of-the-*ReactionEngine*","page":"Home","title":"This package is part of the ReactionEngine","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for ReactionCommons.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [ReactionCommons]","category":"page"},{"location":"#ReactionCommons.Arrhenius","page":"Home","title":"ReactionCommons.Arrhenius","text":"Arrhenius reaction rate parameters\n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.AuxiliaryData","page":"Home","title":"ReactionCommons.AuxiliaryData","text":"Auxiliary reaction data for gasphase kinetics \n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.GasphaseMechanism","page":"Home","title":"ReactionCommons.GasphaseMechanism","text":"Object defining the gasphase reaction mechanism \n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.GasphaseReaction","page":"Home","title":"ReactionCommons.GasphaseReaction","text":"Object defining an elementary gasphase reaction \n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.GasphaseRxnStoichiometry","page":"Home","title":"ReactionCommons.GasphaseRxnStoichiometry","text":"Stoichiometry object for gasphase reactions for an individual reaction \n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.MechanismDefinition","page":"Home","title":"ReactionCommons.MechanismDefinition","text":"An anstract type for surface reaction mechanism parameter definitions\n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.Order","page":"Home","title":"ReactionCommons.Order","text":"Object for defining order of a reaction using FORD or RORD keyword for gasphase reactions \n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.SiteInfo","page":"Home","title":"ReactionCommons.SiteInfo","text":"composite type for the definition of site definition of a surface reaction mechanism\n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.Sri","page":"Home","title":"ReactionCommons.Sri","text":"Parameters for Sri reaction parameters\n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.Troe","page":"Home","title":"ReactionCommons.Troe","text":"Parameters for troe reaction parameters \n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.UserDefinedState","page":"Home","title":"ReactionCommons.UserDefinedState","text":"User state for use in user defined reaction rate calculations \n\n\n\n\n\n","category":"type"},{"location":"#ReactionCommons.get_dependencies-NTuple{4, Any}","page":"Home","title":"ReactionCommons.get_dependencies","text":"Function to determine the coverage dependency, order dependency and MWC for a reaction\n\nUsage\n\nget_dependencies(cov_dep_rxns,order_dep_rxns,mwc_rxns,rxn_id)\n\ncovdeprxns::Dict{Int64=>Dict{Int64=>Float64}}\norderdeprxns::Dict{Int64=>Dict{Int64=>Float64}}\nmwc_rxns::Array{Int64}\nrxn_id::Int64\n\nThe function returns a tuple of cov,order and mwc\n\n\n\n\n\n","category":"method"},{"location":"#ReactionCommons.parse_rxn_string-Tuple{String}","page":"Home","title":"ReactionCommons.parse_rxn_string","text":"Separate the reactants and products from the stoichiometric equation\n\nUsage:\n\nparase_rxn_string(rxn_str)\n\nrxn_str::String:    String representing the reaction equation\n\n\n\n\n\n","category":"method"},{"location":"#ReactionCommons.species_rxn_map-Tuple{Vector{String}, Mechanism}","page":"Home","title":"ReactionCommons.species_rxn_map","text":"Create array of structures of SpeciesRxnMap. The SpeciesRxnMap is a  composit structure of species_id in participating reactions and the stoichiometric coefficients\n\nUsage\n\nspecies_rxn_map(gas_species,sm)\n\ngas_species::Array{String,1} :  list of gas phase species\nsm::SurfaceMechanism : SurfaceMechanism composite type\n\n\n\n\n\n","category":"method"}]
}
