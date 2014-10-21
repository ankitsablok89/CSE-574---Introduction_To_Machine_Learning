% Author - Ankit Sablok %
% Person # - 5009-6348 %
% PROJECT FILE - CALLING FILE %

% plot the graph of ERMS vs LAMBDA vs VARIANCE for the training set %
cfs_ERMS = importdata('cfs_ERMS.mat');
cfs_LAMBDAS = importdata('cfs_LAMBDAS.mat');
cfs_VARIANCE = importdata('cfs_VARIANCE.mat');
cfs_SD = importdata('cfs_SD.mat');
meanVector = importdata('mu_cfs.mat');
test_gdErrors = importdata('test_gdErrors.mat');
StERMS = importdata('StERMS.mat');

% plot the graph of ERMS vs LAMBDA vs VARIANCE for the validation set %
test_cfsErrors = importdata('test_cfsErrors.mat');

% plot the graph of ERMS vs LAMBDA vs VARIANCE for the validation set %
test_cfsTestErrors = importdata('test_cfsTestErrors.mat');

% plot the graph of different ERMS values for training, validation and testing set
% scatter3(cfs_ERMS, test_cfsErrors, test_cfsTestErrors,'filled');

% plot the mean vector
% contour3(meanVector);
% plotting the ERMS values for test_gd
plot(1:1000, StERMS);