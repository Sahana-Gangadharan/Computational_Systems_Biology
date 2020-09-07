 %hw4_2

%initCobraToolbox

load iAF1260;
minmodel = iAF1260;

WTsoln = optimizeCbModel(minmodel,'max','one');

fprintf('\nWild type flux of biomass production is %f\n',WTsoln.f);

%We need to make sure that the minimal reactome's biomass flux should
%atleast by 95% of WTsoln.f
min = 0.95*(WTsoln.f);
minmodel = changeRxnBounds(minmodel,'BIOMASS_Ec_iAF1260_core_59p81M',min,'l');

%We can then do pFBA with minmodel and identify reaction classes.
[GeneClasses, RxnClasses, modelIrrevFM] = pFBA(minmodel);
fprintf('\npFBA done for identifying various types of reactions in the model\n');

blockedrxn = RxnClasses.Blocked_Rxns;
nb = length(blockedrxn);
fprintf('\nResults - \nThere are %d blocked reactions.',nb);

zerofluxrxn = RxnClasses.ZeroFlux_Rxns;
nz = length(zerofluxrxn);
fprintf('\nResults - \nThere are %d Zero-flux reactions.',nz);

elerxn = RxnClasses.ELE_Rxns;
ne = length(elerxn);
fprintf('\nResults - \nThere are %d enzymatically less-efficient reactions.',ne);

mlerxn = RxnClasses.MLE_Rxns;
nm = length(mlerxn);
fprintf('\nResults - \nThere are %d metabolically less-efficient reactions.\n',nm);

blockedrxn_ind = zeros(nb,1);
for i = 1:nb
    rxn = string(blockedrxn(i));
    index = find(strcmp(rxn,minmodel.rxns));        
    blockedrxn_ind(i,1)=index;
end
minmodel.lb(blockedrxn_ind)=0;
minmodel.ub(blockedrxn_ind)=0;

fprintf('\nAfter deleting blocked reactions, the biomass flux is %f\n.',optimizeCbModel(minmodel).f)

zerofluxrxn_ind = zeros(nz,1);
for i = 1:nz
    rxn = string(zerofluxrxn(i));
    index = find(strcmp(rxn,minmodel.rxns));        
    zerofluxrxn_ind(i,1)=index;
end
minmodel.lb(zerofluxrxn_ind)=0;
minmodel.ub(zerofluxrxn_ind)=0;

fprintf('\nAfter deleting blocked and zero-flux reactions, the biomass flux is %f\n.',optimizeCbModel(minmodel).f)

mlerxn_ind = zeros(ne,1);
for i = 1:nm
    rxn = string(mlerxn(i));
    index = find(strcmp(rxn,minmodel.rxns));        
    mlerxn_ind(i,1)=index;
end
minmodel.lb(mlerxn_ind)=0;
minmodel.ub(mlerxn_ind)=0;

fprintf('\nAfter deleting blocked, zero-flux and MLE reactions, the biomass flux is %f\n.',optimizeCbModel(minmodel).f)

elerxn_ind = zeros(ne,1);
for i = 1:ne
    rxn = string(elerxn(i));
    index = find(strcmp(rxn,minmodel.rxns));        
    elerxn_ind(i,1)=index;
end
minmodel.lb(elerxn_ind)=0;
minmodel.ub(elerxn_ind)=0;

fprintf('\nAfter deleting blocked, zero-flux, MLE and ELE reactions, the biomass flux is %f\n.',optimizeCbModel(minmodel).f)

optrxn = RxnClasses.pFBAOpt_Rxns;
no = length(optrxn);
optrxn_ind = zeros(no,1);
for i =1:no
    rxn = string(optrxn(i));
    index = find(strcmp(rxn,minmodel.rxns));        
    optrxn_ind(i,1)=index;
end

for i = 1:no
    midmodel = minmodel;
    
    midmodel.lb(optrxn_ind(i))=0;
    midmodel.ub(optrxn_ind(i))=0;
    mid_soln = optimizeCbModel(midmodel);
    
    if mid_soln.f>min && mid_soln.stat==1
        minmodel=midmodel;
    end
end
fin = optimizeCbModel(minmodel);
fprintf('\nIdentified minimal reactome has %d reactions and the biomass flux = %f\n',length(find(fin.v)), fin.f);
fprintf('\nThe minimal model is - \n');
disp(minmodel);
