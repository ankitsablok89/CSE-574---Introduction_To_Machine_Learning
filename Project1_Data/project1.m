% Author - Ankit Sablok %
% Person # - 5009-6348 %
% PROJECT FILE - CALLING FILE %

yourubitname = 'ankitsab';
yournumber = 50096348;
M_cfs = 46;
M_gd = 46;
lambda_cfs = 0.414;
lambda_gd = 0.414;
rms_cfs = 0.5648;
rms_gd = 0.5892;

% this is the file that consists of all the query/relevance pairs %
dataFile = fopen('C:\Users\ankitsablok89\Desktop\MS in Computer Science Classes\CSE-574 - Introduction To Machine Learning\Project1_Data\Querylevelnorm.txt');

% this is the data matrix consisting of 69623 x 47 values
dataMatrix = zeros(69623,47);

% read the data file and populate the dataMatrix
lineNumber = 0;
dataString = fgetl(dataFile);
while ischar(dataString)
    lineNumber = lineNumber + 1;
    splitDataString = regexp(dataString,' ','split');
    for i = 1:length(splitDataString)
        if i > 48
            break;
        elseif i == 1
            dataMatrix(lineNumber,i) = str2double(splitDataString{i});
        elseif i == 2
            continue;
        else
            cellSplit = regexp(splitDataString{i},':','split');
            dataMatrix(lineNumber, i-1) = str2double(cellSplit{2});
        end
    end
    dataString = fgetl(dataFile);
end

save('project1_data', 'dataMatrix');

% now we form the training set, validation set and test set for the data
trainingSet = zeros(55699,47);

for i = 1:55699
    for j = 1:47
        trainingSet(i,j) = dataMatrix(i,j);
    end
end

% form the validation set
validationSet = zeros(6962,47);
for i = 55700:62661
    for j = 1:47
        validationSet(i-55699,j) = dataMatrix(i,j);
    end
end

validationSetRelevance = zeros(6962,1);
for i = 1:6962
    validationSetRelevance(i,1) = validationSet(i,1);
end
validationSetWithoutRelevance = zeros(6962,46);
for i = 1:6962
    for j = 1:46
        validationSetWithoutRelevance(i,j) = validationSet(i,j+1);
    end
end

% form the test set
testSet = zeros(6962,47);
for i = 62662:69623
    for j = 1:47
        testSet(i - 62661,j) = dataMatrix(i,j);
    end
end

testSetRelevance = zeros(6962,1);
for i = 1:6962
    testSetRelevance(i,1) = testSet(i,1);
end
testSetWithoutRelevance = zeros(6962,46);
for i = 1:6962
    for j = 1:46
        testSetWithoutRelevance(i,j) = testSet(i,j+1);
    end
end

save('project1_trainingSet', 'trainingSet');
save('project1_validationSet', 'validationSet');
save('project1_validationSetRelevance', 'validationSetRelevance');
save('project1_validationSetWithoutRelevance', 'validationSetWithoutRelevance');
save('project1_testSet', 'testSet');
save('project1_testSetRelevance', 'testSetRelevance');
save('project1_testSetWithoutRelevance', 'testSetWithoutRelevance');


% call the function for cfs
train_cfs();
test_cfs();

% call the function for gradient descent
train_gd();
test_gd();

fprintf('My ubit name is %s\n',yourubitname);
fprintf('My student number is %d \n',yournumber);
fprintf('the model complexity M_cfs is %d\n', M_cfs);
fprintf('the model complexity M_gd is %d\n', M_gd);
fprintf('the regularization parameters lambda cfs is %4.2f\n', lambda_cfs);
fprintf('the regularization parameters lambda gd is %4.2f\n', lambda_gd);
fprintf('the root mean square error for the closed form solution is %4.2f\n', rms_cfs);
fprintf('the root mean square error for the gradient descent method is %4.2f\n', rms_gd);