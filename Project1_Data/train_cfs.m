% Author - Ankit Sablok %
% Person # - 5009-6348 %
% CLOSED FORM SOLUTION - train_cfs.m %

function [] = train_cfs()
    
    % import the training set matrix
    trainingSet = importdata('project1_trainingSet.mat');
    
    % actual relevance values
    trainingSetRelevance = zeros(55699,1);
    trainingSetWithoutRelevance = zeros(55699,46);
    
    % form the actual training set
    for i = 1:55699
        for j = 2:47
            trainingSetWithoutRelevance(i,j-1) = trainingSet(i,j);
        end
    end
    
    % save the training set without the relevance values
    save('project1_trainingSetWithoutRelevance', 'trainingSetWithoutRelevance');
    
    % form the relevance vector of the dataset
    for i = 1:55699
        trainingSetRelevance(i,1) = trainingSet(i,1);
    end
    
    % save the relevance vector of the training set
    save('project1_trainingSetRelevance', 'trainingSetRelevance');
    
    % this vector will store the ERMS values for 5 observations
    ERMS = zeros(1,30);
    % this vector will store all the values of lambdas we use in training
    LAMBDAS = zeros(1,30);
    % this vector will store all the weight matrices generated during iterations
    weightMatrices = zeros(46,30);
    % this vector stores the standard deviations used while calculating
    SD = zeros(1,30);
    % this vector stores the variance used while calculating
    VARIANCE = zeros(1,30);
    
    for k = 1:30
        
        % now we form the mean vector
        meanVector = rand(46,46);
        standardDeviation = rand;
        
        % regularization factor
        lambda = 0.1 + 4*rand;
        LAMBDAS(1,k) = lambda;
        
        % store the standard deviation in the vector
        SD(1,k) = standardDeviation;
        
        % store the variance in the vector
        VARIANCE(1,k) = standardDeviation^2;
        
        % form the phi(x) matrix now
        phiX = zeros(55699,46);
        
        for i = 1:55699
            for j = 1:46
                phiX(i,j) = exp((-0.5)*(trainingSetWithoutRelevance(i,:) - meanVector(j,:))*(trainingSetWithoutRelevance(i,:) - meanVector(j,:))');
            end
        end

        % now evaluate the weight matrix
        identityMatrix = eye(46);
        weightMatrix = (inv(lambda*identityMatrix + phiX' * phiX)) * (phiX') * trainingSetRelevance;
        
        % this the weight matrices
        weightMatrices(:,k) = weightMatrix;
        
        % now we evaluate the error function Ed(w)
        EdW = 0;
        for i = 1:55699
            EdW = EdW + (trainingSetRelevance(i,1) - phiX(i,:)*weightMatrix)^2;
        end

        EdW = EdW/2;
        EwW = 0.0;
    
        for i = 1:46
            EwW = EwW + weightMatrix(i,1)^2;
        end
        Error = EdW + 0.5*EwW;
        Erms = sqrt((2*Error)/55699);
        ERMS(1,k) = Erms;
    end
    
    % save the mean matrix
    save('mu_cfs', 'meanVector');
    % save the mean matrix for the gradient descent
    save('mu_gd', 'meanVector');
    % save the weight matrices
    save('W_cfs', 'weightMatrices');
    % save the lambda matrix
    save('cfs_LAMBDAS', 'LAMBDAS');
    % save the Erms matrix
    save('cfs_ERMS', 'ERMS');
    % save the phiX matrix
    save('cfs_phiX', 'phiX');
    % save the standard deviation matrix
    save('s_cfs', 'SD');
    % save the standard deviation matrix for the gradient descent
    save('s_gd', 'SD');
    % save the variance matrix
    save('cfs_VARIANCE', 'VARIANCE');
end