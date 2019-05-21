function [ dist ] = objectScenesDistance( object, scene1, scene2 )
% Function: Find the distance between the same object in two scenes
% Usage:
% 
%       [ dist ] = objectScenesDistance( object, scene1, scene2 )
%   where:
%       object - object image file
%       scene1 - scene one image file
%       scene2 - scene two image file
%       dist - distance for the object in the two scenes
% 
% Institute: Pontificial Catholic University of Paraná¡
% Author: Cristian Simioni Milani
% Last modified: 20 May. 2019

% Execute SIFT algorithm
[dstImg0, descpt0, locs0] = sift(object);
[dstImg1, descpt1, locs1] = sift(scene1);
[dstImg2, descpt2, locs2] = sift(scene2);

% Number of matches to be found
num = 15;

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

% Calculate the estimated objects coordinates on scene
pos1 = locs1(index1, [2 1]);
pos2 = locs2(index2, [2 1]);

% Calculate the distante
avg1=mean(pos1);
avg2=mean(pos2);
dist = norm(avg1 - avg2);

% Fuse both scenes and draw a line between both object positions
C = imfuse(dstImg1, dstImg2);
C = insertShape(C,'Line',[avg1 avg2],'LineWidth',2,'Color','yellow');
figure, imshow(C);

fprintf('The distance between the objects is approximately %f pixels.\n', dist);

end