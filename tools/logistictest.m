source('logisticTraining.m')
source('logisticPredict.m')

disp('Loading data')
data = load('auto-mpg.data');
disp('Data loaded')

attribs = {'mpg' 'cyls' 'displ' 'hp' 'weight' 'acc' 'yr' 'origin'};
%           mpg          hp           weight		acc
test = [data(1:30, 1) data(1:30,4) data(1:30, 5) data(1:30, 6)];

mpg = test(:,1);
y = zeros(1, 3)
for i = 1:length(mpg),
	y = [y; zeros(1,columns(y))]
	if mpg(i) <= 15,
		y(i,1) = 1; %low mpg
	elseif mpg(i) <= 25
		y(i,2) = 1; %high mpg
	else
		y(i,3) = 1;
	end
end
y


disp('Starting logistic training');
x = test(:,2:4);
[w, means, ranges] = logisticTraining(x, y, 1000, 0.01);
disp('...done');

w
means
ranges

samp = [1 test(1,2:4)] %sample to predict
prediction = logisticPredict(samp, w ,means, ranges);
prediction

