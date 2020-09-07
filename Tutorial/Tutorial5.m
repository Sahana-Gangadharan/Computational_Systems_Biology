%Lab 03-04-20

initCobraToolbox;
model = readCbModel; %import iAF1260

sol = optimizeCbModel(model);
norm = norm(sol.x);
norm1 = norm(model.S*sol.x);

%pFBA - most optimum/efficient solution
help pFBA;
sol2 = optimizeCbModel(model,'max','one');
norm2 = norm(sol2.x);

%Another model
ecoli = readCbModel; %import ecoli-core-model
ecolisol = optimizeCbModel(ecoli);
norm3 = norm(ecolisol.x);

ATPS_bool = ismember(ecoli.rxns,'ATPS');
ATPM_bool = ismember(ecoli.rxns,'ATPM');

RxnName = ecoli.rxnNames(11);

%Single reaction deletion and Single gene deletion
help singleGeneDeletion;

[grRatio, grRateKO, grRateWT, hasEffect, delRxns, fluxSolution] = singleGeneDeletion(model);
per5 = ecoli.rxnNames(grRatio<0.05);
per80 = ecoli.rxnNames(grRatio<0.8);
