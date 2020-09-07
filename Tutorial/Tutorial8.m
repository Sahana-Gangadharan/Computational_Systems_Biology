%Lab 17-04-2020

%initCobraToolbox

model = readCbModel('iAF1260.mat');
%965th rxn is exchange of tryptophan - product
WTsoln = optimizeCbModel(model);
len = length(WTsoln.v);
WTRxns = model.rxns;
disp(WTsoln);
%Change objective function

obj_fun = model.c;
k = find(obj_fun==1);

test = model;
test.c(k)=0;
test.c(965)=1;
testsoln = optimizeCbModel(test);
disp(testsoln);

max_Vp = testsoln.f;
vj = zeros(10,len);
VP = zeros(10,1);

for i=0.1:1.0
    Vp = i*max_Vp;
    VP(i*10)=Vp;
    new = changeRxnBounds(model,'EX_trp__L_e',Vp,'b');
    x = optimizeCbModel(new);
    vj(i*10,:)=x.v;
end

for i=1:len
    all_v = vj(:,i);
    plot(VP,all_v);
end

