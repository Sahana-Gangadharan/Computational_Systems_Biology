%hw4_1

initCobraToolbox;
%Helicobacter pylori is referred to as hmodel in this program.

load iIT341.mat;
hmodel = iIT341;
WTsolution = optimizeCbModel(hmodel);
hmodel = buildRxnGeneMat(hmodel);
[Jslw,Jdlw] = fastSL_dg(hmodel,0.05);

fprintf('\nBiomass growth rate in the wildtype conditions is = %f\n',WTsolution.f);
fprintf('Displaying the synthetic double lethals in this model\n');
disp(Jdlw);

%Setting glucose as carbon source 
test1 = changeRxnBounds(hmodel,'EX_glc__D_e',-10,'l');
testsoln1 = optimizeCbModel(test1);
test1 = buildRxnGeneMat(test1);
[Jsl1,Jdl1] = fastSL_dg(test1,0.05);

fprintf('\nBiomass growth rate with glucose as carbon source is = %f\n',testsoln1.f);
fprintf('Displaying the synthetic double lethals in this model\n');
disp(Jdl1);

%Setting galactose as carbon source 
test2 = changeRxnBounds(hmodel,'EX_gal_e',-10,'l');
testsoln2 = optimizeCbModel(test2);
test2 = buildRxnGeneMat(test2);
[Jsl2,Jdl2] = fastSL_dg(test2,0.05);

fprintf('\nBiomass growth rate with galactose as carbon source is = %f\n',testsoln2.f);
fprintf('Displaying the synthetic double lethals in this model\n');
disp(Jdl2);

%Setting glucose and galactose as carbon source 
test3 = changeRxnBounds(hmodel,'EX_gal_e',-10,'l');
test3 = changeRxnBounds(test3,'EX_glc__D_e',-10,'l');
testsoln3 = optimizeCbModel(test3);
test3 = buildRxnGeneMat(test3);
[Jsl3,Jdl3] = fastSL_dg(test3,0.05);

fprintf('\nBiomass growth rate with both glucose and galactose as carbon source is = %f\n',testsoln3.f);
fprintf('Displaying the synthetic double lethals in this model\n');
disp(Jdl3);
