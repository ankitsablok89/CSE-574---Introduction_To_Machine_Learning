% Author - Ankit Sablok %
% Person # - 5009-6348 %
% TESTING THE CLOSED FORM SOLUTION %

function [] = test_gd()
    
    % this matrix stores all the vectors obtained from train_gd
    gdWeightVectors = zeros(46,5);
    
    % validation set without relevance and with relevance
    test_gdValidationSetWithoutRelevance = importdata('project1_validationSetWithoutRelevance.mat');
    test_gdValidationSetRelevance = importdata('project1_validationSetRelevance.mat');
    
    % mean vector used for testing purposes
    test_gdValidationMeanVector = rand(46,46);
    
    % start 5 iterations of train_gd
    for i = 1:5
        train_gd();
        weightVector = importdata('gdWeightVector.mat');
        gdWeightVectors(:,i) = weightVector;
    end
    
    % form the phi(x) matrix now
    test_gdValidationPhiX = zeros(6962,46);
    for i = 1:6962
        for j = 1:46
            test_gdValidationPhiX(i,j) = exp((-0.5)*(test_gdValidationSetWithoutRelevance(i,:) - test_gdValidationMeanVector(j,:))*(test_gdValidationSetWithoutRelevance(i,:) - test_gdValidationMeanVector(j,:))');
        end
    end
    
    % evaluate the square error
    test_gdSquareErrorFunction = zeros(1,5);
    for i = 1:5
        test_gdSquareErrorFunction(1,i) = (test_gdValidationPhiX * gdWeightVectors(:,i) - test_gdValidationSetRelevance)'*(test_gdValidationPhiX * gdWeightVectors(:,i) - test_gdValidationSetRelevance);
    end
    
    % evaluate the square errors
    test_gdErrors = zeros(1,5);
    for i = 1:5
        test_gdErrors(1,i) = sqrt(test_gdSquareErrorFunction(1,i)/6962);
    end
    save('test_gdErrors', 'test_gdErrors');
    save('gdWeightVectors', 'gdWeightVectors');
    
    % test set without relevance and with relevance
    test_gdTestSetWithoutRelevance = importdata('project1_testSetWithoutRelevance.mat');
    test_gdTestSetRelevance = importdata('project1_testSetRelevance.mat');
    
    % form the phi(x) matrix now
    test_gdTestPhiX = zeros(6962,46);
    for i = 1:6962
        for j = 1:46
            test_gdTestPhiX(i,j) = exp((-0.5)*(test_gdTestSetWithoutRelevance(i,:) - test_gdValidationMeanVector(j,:))*(test_gdTestSetWithoutRelevance(i,:) - test_gdValidationMeanVector(j,:))');
        end
    end
    
    % evaluate the square error
    test_gdTestSquareErrorFunction = zeros(1,5);
    for i = 1:5
        test_gdTestSquareErrorFunction(1,i) = (test_gdTestPhiX * gdWeightVectors(:,i) - test_gdTestSetRelevance)'*(test_gdTestPhiX * gdWeightVectors(:,i) - test_gdTestSetRelevance);
    end
    
    % evaluate the square errors
    test_gdTestErrors = zeros(1,5);
    for i = 1:5
        test_gdTestErrors(1,i) = sqrt(test_gdTestSquareErrorFunction(1,i)/6962);
    end
    
    save('test_gdTestErrors', 'test_gdTestErrors');
end