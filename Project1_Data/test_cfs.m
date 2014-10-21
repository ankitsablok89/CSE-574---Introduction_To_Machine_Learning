% Author - Ankit Sablok %
% Person # - 5009-6348 %
% TESTING THE CLOSED FORM SOLUTION %

function [] = test_cfs()

    LAMBDAS = importdata('cfs_LAMBDAS.mat');
    ERMS = importdata('cfs_ERMS.mat');
    weightMatrices = importdata('W_cfs.mat');
    project1_validationSetRelevance = importdata('project1_validationSetRelevance.mat');
    project1_validationSetWithoutRelevance = importdata('project1_validationSetWithoutRelevance.mat');
    
    % mean vector used for testing purposes
    validationMeanVector = rand(46,46);
    
    % form the phi(x) matrix now
    validationPhiX = zeros(6962,46);
        
    for i = 1:6962
        for j = 1:46
            validationPhiX(i,j) = exp((-0.5)*(project1_validationSetWithoutRelevance(i,:) - validationMeanVector(j,:))*(project1_validationSetWithoutRelevance(i,:) - validationMeanVector(j,:))');
        end
    end
    
    squareErrorFunction = zeros(1,30);
    
    for i = 1:30
        squareErrorFunction(1,i) = (validationPhiX * weightMatrices(:,i) - project1_validationSetRelevance)'*(validationPhiX * weightMatrices(:,i) - project1_validationSetRelevance);
    end
    
    % evaluate the ERMS function
    test_cfsErrors = zeros(1,30);
    for i = 1:30
        test_cfsErrors(1,i) = sqrt(squareErrorFunction(1,i)/6962);
    end
    
    % save the required parameters
    save('project1_test_cfs_validationMeanVector', 'validationMeanVector');
    save('project1_test_cfs_validationPhiX', 'validationPhiX');
    save('project1_test_cfs_squareErrorFunction', 'squareErrorFunction');
    save('test_cfsErrors', 'test_cfsErrors');
    
    project1_testSetRelevance = importdata('project1_testSetRelevance.mat');
    project1_testSetWithoutRelevance = importdata('project1_testSetWithoutRelevance.mat');
    
    % mean vector used for testing purposes
    testMeanVector = rand(46,46);
    
    % form the phi(x) matrix now
    testPhiX = zeros(6962,46);
        
    for i = 1:6962
        for j = 1:46
            testPhiX(i,j) = exp((-0.5)*(project1_testSetWithoutRelevance(i,:) - testMeanVector(j,:))*(project1_testSetWithoutRelevance(i,:) - testMeanVector(j,:))');
        end
    end
    
    testSquareErrorFunction = zeros(1,30);
    
    for i = 1:30
        testSquareErrorFunction(1,i) = (testPhiX * weightMatrices(:,i) - project1_testSetRelevance)'*(testPhiX * weightMatrices(:,i) - project1_testSetRelevance);
    end
    
    % evaluate the ERMS function
    test_cfsTestErrors = zeros(1,30);
    for i = 1:30
        test_cfsTestErrors(1,i) = sqrt(testSquareErrorFunction(1,i)/6962);
    end
    
    save('test_cfsTestErrors', 'test_cfsTestErrors');
end