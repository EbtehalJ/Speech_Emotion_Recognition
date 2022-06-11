% Specify the folder where the files live.
myFolder = 'C:\Users\ebteh\Desktop\Data';
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '**/*.wav'); % Change to whatever pattern you need.
sounds = dir(filePattern);
num_files = length(sounds);
mydata = cell(1, num_files);
for k = 1 : num_files 
    baseFileName{k} = sounds(k).name;
    fullFileName = fullfile(sounds(k).folder, baseFileName{k});
    % read audio file
    [mydata{k}, Fs] = audioread(fullFileName);

    % apply five-level wavelet decomposition 
    [c,l]=wavedec(mydata{k},5,'db5');

    % approximation and detail sub-bands coefficients
    [Ea{k},Ed{k}]=wenergy(c,l);
    % wentropy
    went{k} = wentropy(mydata{k}, 'shannon')
end