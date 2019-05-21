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

close all;
clear;
clc;

% Example how to calculate the distance between two objects in the same scene
dist = objectsDistance("images/book1.jpg", "images/book2.jpg", "images/scene1.jpg");

% Example how to calculate the distance between initial and final object position 
% in two scenes
dist = objectScenesDist("images/book1.jpg","images/scene1.jpg","images/scene2.jpg");