%Uses code from the Deep Learning Toolbox: https://github.com/rasmusbergpalm/DeepLearnToolbox
addpath(genpath('DeepLearnToolbox'));
addpath(genpath('tools'));

%Parker: Reads in the data that Dan collected
co  = textread('data/Co.txt', '%s');
state = textread('data/State.txt', '%d');
field = csvread('data/Field.txt');
date = textread('data/Date.txt', '%d');

%Compiles the data into one matrix
data = [];
for i = 1:rows(co)
	row = [co(i) state(i) date(i)];
	data{i} = row;
endfor

