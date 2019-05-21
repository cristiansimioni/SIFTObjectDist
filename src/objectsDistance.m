function [ dist ] = objectsDistance( object1, object2, scene )
% Function: Find the distance two objects in the same imageeeee
% Usage:
% 
%       [ dist ] = objectScenesDistance( object, scene1, scene2 )
%   where:
%       object1 - object one image file
%       object2 - object two image file
%       scene - scene image file
%       dist - distance between the objects
% 
% Institute: Pontificial Catholic University of Paraná¡
% Author: Cristian Simioni Milani
% Last modified: 20 May. 2019

% Execute SIFT algorithm
[dstImgObj1, descptObj1, locsObj1] = sift(char(object1));
[dstImgObj2, descptObj2, locsObj2] = sift(char(object2));
[dstImgScene, descptScene, locsScene] = sift(char(scene));

% Number of matches to be found
num = 15;

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

% Calculate the estimated object coordinate on scenes
pos1 = locsScene(indexScene1, [2 1]);
pos2 = locsScene(indexScene2, [2 1]);

% Calculate the distante
avg1=mean(pos1);
avg2=mean(pos2);
dist = norm(avg1 - avg2);

% Draw a line between both object positions
sceneDist = insertShape(dstImgScene,'Line',[avg1 avg2],'LineWidth',2,'Color','yellow');
figure, imshow(sceneDist);

fprintf('The distance between the objects is approximately %f pixels.\n', dist);

end