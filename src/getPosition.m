function [ posXY, objImg, objDes, objLoc, objIdx, scnImg, scnDes, scnLoc, scnIdx ] = getPosition( objImgSrc, scnImgSrc )
% Function: Find the estimated position (x,y) for an object on a scene
% Usage:
%
%       [ posXY, objImg, objDes, objLoc, objIdx, scnImg, scnDes, scnLoc, scnIdx ] = getPosition( objImgSrc, scnImgSrc )
%   where:
%       objImgSrc - object image file
%       scnImgSrc - scene image file
%       posXY - estimated position of object in scene
%       objImg - object image
%       objDes - object descriptor set
%       objLoc - 
%       objIdx - indices of the matched features in the object image      
%       scnImg - scene image     
%       scnDes - scene descriptor set
%       scnLoc -
%       scnIdx - indices of the matched features in the scene image    
% 
% Institute: Pontificial Catholic University of Paraná
% Author: Cristian Simioni Milani
% Last modified: 20 May. 2019

% Execute SIFT algorithm
[objImg, objDes, objLoc] = sift(objImgSrc);
[scnImg, scnDes, scnLoc] = sift(scnImgSrc);

% Number of matches to be found
num = 15;

% Match the SIFT descriptor for the first object and scene
[scnIdx, objIdx] = SIFTmatch(scnDes, objDes, num);

% Calculate the estimated object coordinate on scene
pos = scnLoc(scnIdx, [2 1]);
posXY = mean(pos);

end

