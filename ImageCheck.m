clear all
close all

for i = 1:15
    figure(i)
    imageName = strcat('Color', num2str(i), '.jpg');
    try
    BoxFind(imageName)
    catch
    fprintf('Failed on number %d \n', i)
    end
end