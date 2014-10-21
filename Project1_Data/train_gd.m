% Author - Ankit Sablok %
% Person # - 5009-6348  %
% GRADIENT DESCENT SOLUTION %

function [] = train_gd()
    
    % this is the gaussian evaluate from the training set
    train_gdPhiX = importdata('cfs_phiX.mat');
    
    % this is the training set relevance data
    train_gdTrainingSetRelevance = importdata('project1_trainingSetRelevance.mat');
    
    % this is the initial weight vector we use for the computation
    weightVector = rand(46,1);
    
    % this is the initial value of ita which is 1.0
    ita = 1;
    tempW = weightVector;
    tempEdW = 0;
    
    % calculate the initial error which is w^(tau)
    for j = 1:55699
        tempEdW = tempEdW + (train_gdTrainingSetRelevance(j,1) - train_gdPhiX(j,:)*tempW)^2;
    end
    
    % this vector stores the values of all the StErms
    StERMS = zeros(1000,1);
    
    % execute 100 iterations
    for i = 1:100
    
        newW = tempW + ita*(train_gdTrainingSetRelevance(i,1) - train_gdPhiX(i,:)*tempW) * train_gdPhiX(i,:)';
        newEdW = 0;
    
        for j = 1:55699
            newEdW = newEdW + (train_gdTrainingSetRelevance(j,1) - train_gdPhiX(j,:)*newW)^2;
        end
    
        if newEdW - tempEdW > 0
            ita = ita/2;
        else
            StErms = sqrt(tempEdW/55699);
            StERMS(i,1) = StErms;
        end
    
        tempEdW = newEdW;
        tempW = newW;
    end
    
    % save the stochastic ERM's values
    save('StERMS', 'StERMS');
    save('gdWeightVector','newW');
end