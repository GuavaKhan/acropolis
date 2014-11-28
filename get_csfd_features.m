Cs = {"GE", "AXP", "GS", "JPM", "V", "CAT", "CVX", "XOM", "TRV", "WMT", "MCD", "INTC", "MSFT", "CSCO", "IBM", "JNJ", "PFE", "PG", "MMM", "BA", "UTX", "T", "VZ", "DD", "HD", "MRK", "NKE", "KO", "UNH", "DIS"};
source('./readCoStateFieldDate.mat');

for(i = 1:length(Cs))

	filename = sprintf("./companiesData/%s/CoStateFieldDate.txt", Cs{i});
	[Features, binaryFieldArray] = readCoStateFieldDate(filename);

endfor