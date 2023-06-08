using StatsKit, RCall, JellyMe4, DataFrames, RData, DisplayAs

choicedata = load("/Users/joseph.orr/Documents/repositories/vts_expectancy_f22/Rdata/choice_noErr_data.Rds");
choicedata = dropmissing(choicedata, :participant);

choice_id_m1 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * bisC * basrrC + (1 | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_id_m2 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * bisC * basrrC + (1 + rewCond * prevRew | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_id_m3 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * bisC * basrrC + (1 + rewCond + prevRew | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_bas_m1 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * basrrC + (1 | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_bas_m2 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * basrrC + (1 + rewCond * prevRew | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_bas_m3 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * basrrC + (1 + rewCond + prevRew | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_bis_m1 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * bisC + (1 | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_bis_m2 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * bisC + (1 + rewCond * prevRew | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

choice_bis_m3 = fit(MixedModel, @formula(alt ~ 1 + rewCond * prevRew * rewExpectancy * genderid * bisC + (1 + rewCond + prevRew | participant)), choicedata, Bernoulli(), contrasts = Dict(:rewCond => EffectsCoding(base = "Hi"), :prevRew => EffectsCoding(base = "hi"), :rewExpectancy => EffectsCoding(base = "high")))

R"library(readr)"

choice_id_m3_j = (choice_id_m3, choicedata);
@rput choice_id_m3_j;
R"write_rds(choice_id_m3_j, 'Rdata/choice_id_m3.Rds')";


choice_bas_m1_j = (choice_bas_m1, choicedata);
@rput choice_bas_m1_j;
R"write_rds(choice_bas_m1_j, 'Rdata/choice_bas_m1.Rds')";

choice_bis_m3_j = (choice_bis_m3, choicedata);
@rput choice_bis_m3_j;
R"write_rds(choice_bis_m3_j, 'Rdata/choice_bis_m3.Rds')";


## Print fixed effects parameters
open("choice_id_model.md", "w") do io
    show(io, MIME("text/markdown"), choice_id_m3)
end

open("choice_bas_model.md", "w") do io
    show(io, MIME("text/markdown"), choice_bas_m1)
end

open("choice_bis_model.md", "w") do io
    show(io, MIME("text/markdown"), choice_bis_m3)
end

Choice ID M1 vs. M3
───────────────────────────────────────────────────
     model-dof    deviance       χ²  χ²-dof  P(>χ²)
───────────────────────────────────────────────────
[1]         65  34441.6984
[2]         70  34402.5301  39.1683       5  <1e-06
───────────────────────────────────────────────────

───────────────────────────────────────────────────