% Lab 15-04-20

% initCobraToolbox;
ecoli = readCbModel;
WTsoln = optimizeCbModel(ecoli);

%double gene deletion
tic;
[grRatioDble, grRateKO, grRateWT] = doubleGeneDeletion(ecoli);
toc;
%grRatioDble = 137*137 double vector
%grRateKO = 137*137 double vector
%grRateWT = 0.8739

%FAST-SL
%go to FastSL-master\Rxns
[Jsl,Jdl] = doubleSL(ecoli);
%Jsl = 18*1 cell
%Jdl = 111*2 cell