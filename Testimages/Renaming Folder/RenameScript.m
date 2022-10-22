files = dir('*.jpg')

for id = 1:length(files)
    % Get the file name 
    [~, f,ext] = fileparts(files(id).name);
    rename = strcat('ASY',num2str(id),ext) ;
    movefile(files(id).name, rename); 
end