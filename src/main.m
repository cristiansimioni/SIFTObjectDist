%% ------------------------------------------------------------------------
% Finding distance between objects in images using SIFT
% -------------------------------------------------------------------------
% Institute: Pontificial Catholic University of Paraná
% Author: Cristian Simioni Milani
% Last modified: 20 May. 2019
%
% Credits: Special thanks to Zhen Zhang who implemented SIFTmatch function 
% that is used on this code. 
%% ------------------------------------------------------------------------
% This main file shows the detailed execution, but you can simple run the 
% functions if you want:
%
% Example how to calculate the distance between two objects in the same 
% scene:
%
%   dist = objectsDistance('images/book1.jpg', 'images/book2.jpg', 'images/scene1.jpg');
%
% Example how to calculate the distance between initial and final object position 
% in two scenes:
%
%   dist = objectScenesDistance('images/book1.jpg','images/scene1.jpg','images/scene2.jpg');
%% ------------------------------------------------------------------------

close all;
clear;
clc;

% Read input images
obj1ImgFile  = 'images/book1.jpg';
obj2ImgFile  = 'images/book2.jpg';
sceneImgFile = 'images/scene1.jpg';

% Find the estimated position for the first object on scene
[ obj1PosXY, obj1Img, obj1Des, obj1Loc, obj1Idx, scn1Img, scn1Des, scn1Loc, scn1Idx ] = getPosition(obj1ImgFile, sceneImgFile);
% Find the estimated position for the second object on scene
[ obj2PosXY, obj2Img, obj2Des, obj2Loc, obj2Idx, scn2Img, scn2Des, scn2Loc, scn2Idx ] = getPosition(obj2ImgFile, sceneImgFile);

% Display the features
showkeys(obj1Img, obj1Loc);
showkeys(obj2Img, obj2Loc);
showkeys(scn1Img, scn1Loc);

% Match the SIFT descriptor for the first object and scene
[scn1Idx, obj1Idx] = SIFTmatch(scn1Des, obj1Des, 15);
% Match the SIFT descriptor for the second object and scene
[scn2Idx, obj2Idx] = SIFTmatch(scn2Des, obj2Des, 15);

% Draw a line between the two position
scnDist = insertShape(scn2Img,'Line',[obj1PosXY obj2PosXY],'LineWidth',2,'Color','yellow');
figure, imshow(scnDist);

% Show the result on console
dist = norm(obj1PosXY - obj2PosXY);
fprintf('The distance between the objects is approximately %f pixels.\n', dist);