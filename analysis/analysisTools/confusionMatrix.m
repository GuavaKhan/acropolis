%Computes the confusion matrix for a set of outputs and their targets
function matrix = confusionMatrix(target, output)
	confusionMatrix = zeros(2, 2);
	%TP
	confusionMatrix(1, 1) = sum((output == 1) & (target == 1));
	%FN
	confusionMatrix(1, 2) = sum((output == 0) & (target == 1));
	%FP
	confusionMatrix(2, 1) = sum((output == 1) & (target == 0));
	%TN
	confusionMatrix(2, 2) = sum((output == 0) & (target == 0));
	matrix = confusionMatrix;
end