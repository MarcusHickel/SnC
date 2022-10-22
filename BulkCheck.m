clear all
close all

Prefix = 'Color';

j = length(dir(['Testimages/', Prefix, '*.jpg']));

figure;
h = zeros(ceil(sqrt(j)));

for i = 1:j
    h(i) = subplot(4,4,i);
    imageName = strcat(Prefix, num2str(i), '.jpg');
    try
    BoxFind(imageName);
    catch
    fprintf('Failed on number %d \n', i)
    end
end