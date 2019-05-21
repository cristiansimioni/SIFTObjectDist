function [ dist ] = objectScenesDist( object, scene1, scene2 )
% Function: 
% Usage:
% 
%       
%   where:
%       dist -
% 
% Institute: Pontificial Catholic University of Paraná
% Author: Cristian Simioni Milani
% Last modified: 20 May. 2019

num = 15;

% Perfrom SIFT
[dstImg0, descpt0, locs0] = sift(char(object));
[dstImg1, descpt1, locs1] = sift(char(scene1));
[dstImg2, descpt2, locs2] = sift(char(scene2));

% Display the features
showkeys(dstImg0, locs0);
showkeys(dstImg1, locs1);
showkeys(dstImg2, locs2);

% Match the SIFT descriptor accross two images
[index0, index1] = SIFTmatch(descpt0, descpt1, num);
[index0, index2] = SIFTmatch(descpt0, descpt2, num);

% Draw the matched features
figure;
showMatchedFeatures(dstImg0, dstImg1, ...
    locs0(index0, [2 1]), locs1(index1, [2 1]), 'montage');

figure;
showMatchedFeatures(dstImg0, dstImg2, ...
    locs0(index0, [2 1]), locs2(index2, [2 1]), 'montage');

I = dstImg1;
M = locs1(index1, [2 1]);
col = zeros(num,1);
col(num,:) = 3;
arr = [M col];
insertShape(I, 'circle', arr, 'LineWidth',5);
RGB = insertShape(I, 'circle', arr, 'LineWidth',5);
figure, imshow(RGB)

I = dstImg2;
M = locs2(index2, [2 1]);
col = zeros(num,1);
col(num,:) = 3;
arr = [M col];
insertShape(I, 'circle', arr, 'LineWidth',5);
RGB = insertShape(I, 'circle', arr, 'LineWidth',5);
figure, imshow(RGB)



% distancia entre dois pontos
imagem1 = locs1(index1, [2 1]);
imagem2 = locs2(index2, [2 1]);

media1=mean(imagem1);
media2=mean(imagem2);

dist = norm(media1 - media2);

C = imfuse(dstImg1, dstImg2);
C = insertShape(C,'Line',[media1 media2],'LineWidth',2,'Color','yellow');
figure, imshow(C);

fprintf('A dist�ncia entre os livros � de aproximadamente %f pixels.\n', dist);


end

