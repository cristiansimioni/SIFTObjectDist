function [ dist ] = objectsDistance( object1, object2, scene )
% Function: Match the SIFT descriptors between two images
% Usage:
% 
%       [index1, index2] = SIFTmatch(descpt1, descpt2, num)
%   where:
%       index1 - indices of the matched features in the first set
%       index2 - indices of the matched features in the second set
%       num - number of valid matches
%       descpt1 - first descriptor set
%       descpt2 - second descriptor est
% 
% Institute: Australian National University
% Author: Zhen Zhang
% Last modified: 1 Apr. 2018

num = 15;       % Number of matches to be found

% Execute SIFT algorithm
[dstImgObj1, descptObj1, locsObj1] = sift(char(object1));
[dstImgObj2, descptObj2, locsObj2] = sift(char(object2));
[dstImgScene, descptScene, locsScene] = sift(char(scene));

% Display the features
showkeys(dstImgObj1, locsObj1);
showkeys(dstImgObj2, locsObj2);
showkeys(dstImgScene, locsScene);

% Match the SIFT descriptor for object 1 and scene
[indexScene1, indexObj1] = SIFTmatch(descptScene, descptObj1, num);
% Match the SIFT descriptor for object 2 and scene
[indexScene2, indexObj2] = SIFTmatch(descptScene, descptObj2, num);

% Draw the matched features
figure;
showMatchedFeatures(dstImgObj1, dstImgScene, ...
    locsObj1(indexObj1, [2 1]), locsScene(indexScene1, [2 1]), 'montage');

figure;
showMatchedFeatures(dstImgObj2, dstImgScene, ...
    locsObj2(indexObj2, [2 1]), locsScene(indexScene2, [2 1]), 'montage');

%I = dstImg1;
%M = locs1(index1, [2 1]);
%col = zeros(num,1);
%col(num,:) = 3;
%arr = [M col];
%insertShape(I, 'circle', arr, 'LineWidth',5);
%RGB = insertShape(I, 'circle', arr, 'LineWidth',5);
%figure, imshow(RGB)

%I = dstImg2;
%M = locs2(index2, [2 1]);
%col = zeros(num,1);
%col(num,:) = 3;
%arr = [M col];
%insertShape(I, 'circle', arr, 'LineWidth',5);
%RGB = insertShape(I, 'circle', arr, 'LineWidth',5);
%figure, imshow(RGB)

% distancia entre dois pontos
imagem1 = locsScene(indexScene1, [2 1]);
imagem2 = locsScene(indexScene2, [2 1]);

objAvg1=mean(imagem1);
objAvg2=mean(imagem2);

dist = norm(objAvg1 - objAvg2);


sceneDist = insertShape(dstImgScene,'Line',[objAvg1 objAvg2],'LineWidth',2,'Color','yellow');
figure, imshow(sceneDist);

fprintf('A distância entre os objetos é de aproximadamente %f pixels.\n', dist);

end

