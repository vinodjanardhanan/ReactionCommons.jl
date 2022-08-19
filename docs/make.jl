using ReactionCommons
using Documenter

DocMeta.setdocmeta!(ReactionCommons, :DocTestSetup, :(using ReactionCommons); recursive=true)

makedocs(;
    modules=[ReactionCommons],
    authors="Vinod Janardhanan",
    repo="https://github.com/vinodjanardhanan/ReactionCommons.jl/blob/{commit}{path}#{line}",
    sitename="ReactionCommons.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://vinodjanardhanan.github.io/ReactionCommons.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/vinodjanardhanan/ReactionCommons.jl",
    devbranch="main",
)
