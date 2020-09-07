%Lab 10-04-20
initCobraToolbox;
model = readCbModel; %import iAF1260
ecoli = readCbModel; %import ecoli-core-model

%Find exchange reactions
ExnRxn = model.rxns(findExcRxns(model));
WTsoln = optimizeCbModel(model);

%q3
test = changeRxnBounds(model,'EX_glc__D_e',0,'l');
test = changeRxnBounds(model,'EX_succ_e',-10,'l');
testsoln = optimizeCbModel(test);

%q4
help fluxVariability;
%Still havent figured out why FVA doesnt work for iAF1260
[min,max]= fluxVariability(ecoli,100,'max',{'FRD7'});

%q5
test = changeRxnBounds(ecoli,'EX_o2(e)',17,'b');
for i=-50:0
    modelq5 = changeRxnBounds(ecoli,'EX_glc(e)',i,'l');
    x = optimizeCbModel(modelq5);
    plot(i,x.f,'x');
    hold on
end