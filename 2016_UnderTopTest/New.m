% Project start date 2016/10/19
% Author signs in here:
% Yang Lu


% standard start
clear all;
clc;
sca;
Screen('Preference', 'SkipSyncTests', 1); 

SONA = inputdlg('What is the SONA ID?');
filename = char(strcat(SONA,'_PreTest.txt'));
CSVfile = fopen(filename, 'w');

%wrtie something
%fprintf(CSVfile, '%s,%s,%s,%s,%s,%s,%s\n','Cue','Arrow','Position','Resp','Comp','Correct','RT');


% PseudoCode : 
% initialization

% instruction
    % 1 screen

% Practice rounds
    % 13 rounds
    % same as actual test
    
% notice the test begins
    % 1 screens
    
% Actual Test
    % 30 rounds
    % stimuli
        % description
        % Picture
    % options
        % T/F
    % Choose a better picture if false otherwise go on
        % 4 options
    % next
        % click the arrow
    
% end
    % 1 screen
        % you are done!
        
%-----------------------
% function list:
% F (Whole Screen covered a  .jpg, and pause)
% F (T/F)
% F (4 pictures)