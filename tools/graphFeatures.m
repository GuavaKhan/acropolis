%This function graphs the data to give visual representation
%x - The features in a matrix of the format samples x features.
%y - the corresponding expected value (raw value, function will bucket them equally)
%bucketThreshold - the threshold for each bucket wanted ex.
% If I want to split data to 3 buckets I can do pass in
% [0,0.01;0.01,0.02;0.02,inf]; it will split the data to 3 buckets 
%between 0-0.01, between 0.01-0.02 and above 0.02.
%Due to matlab  there are only 8 different colours. 
%So anything above 8 buckets could be confusing for this function
function graphFeatures(x, y, bucketThreshold)
	clf;
	colours = {'r*', 'k*', 'b*', 'c*', 'm*', 'g*', 'w*'};
	tableSize = size(x)(2);
	%Number of buckets.
	bucketCount = size(bucketThreshold)(1);
	
	for i = 1:tableSize
		%Choose the correct subplot
		subplot(floor(sqrt(tableSize)) + 1, floor(sqrt(tableSize)) + 1, i); 
		%Choose feature to graph
		features = x(:,i);
		hold on;
		for j = 1:bucketCount
			%Values that fall in the buckets
			values = (y > bucketThreshold(j, 1)) & (y < bucketThreshold(j, 2));
			% Get the corresponding y values
			plotY = y(find(values),:);
			% Get the features that match the y values.
			plotX = features(find(values),:);
			plot(plotX, plotY, colours(j));
		end
		hold off;
	end
end
