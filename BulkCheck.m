clear all
close all

Prefix = 'ASY';

j = length(dir(['Testimages/', Prefix, '*.jpg']));

figure;
h = zeros(ceil(sqrt(j)));

for i = 1:j
    h(i) = subplot(ceil(sqrt(j)),ceil(sqrt(j)),i);
    imageName = strcat(Prefix, num2str(i), '.jpg');
    try
    BoxFind(imageName);
    catch
    fprintf('Failed on number %d \n', i)
    end
end