clear all
close all

for i = 1:6
    figure(i)
    imageName = strcat('rot', num2str(i), '.jpg');
    try
        BoxFind(imageName);
    catch
        fprintf('Failed on number %d \n', i)
    end
end