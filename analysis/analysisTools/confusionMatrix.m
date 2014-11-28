%Computes the confusion matrix for a set of outputs and their targets
function matrix = confusionMatrix(target, output)
	confusionMatrix = zeros(2, 2);
	confusionMatrix(1, 1) = sum((output == 1) & (target == 1));
	confusionMatrix(1, 2) = sum((output == 0) & (target == 1));
	confusionMatrix(2, 1) = sum((output == 1) & (target == 0));
	confusionMatrix(2, 2) = sum((output == 0) & (target == 0));
	matrix = confusionMatrix;
end