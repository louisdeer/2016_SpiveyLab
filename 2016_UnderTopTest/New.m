clear all;
clc;
sca;
Screen('Preference', 'SkipSyncTests', 1); 

SONA = inputdlg('What is the SONA ID?');
filename = char(strcat(SONA,'_PreTest.txt'));
CSVfile = fopen(filename, 'w');

fprintf(CSVfile, '%s,%s,%s,%s,%s,%s,%s\n','Cue','Arrow','Position','Resp','Comp','Correct','RT');
try
PsychDefaultSetup(2);

screenNumber = max(Screen('Screens')); 
white = WhiteIndex(screenNumber);
grey = white / 2;
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black, [], 32, 2);
Screen('TextSize',window, 40);
Screen('Flip', window);


HideCursor;
ifi = Screen('GetFlipInterval', window);
[xCenter, yCenter] = RectCenter(windowRect);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');%???

LEFT = KbName('q');
RIGHT = KbName('p');


instruction = imread('Instructions.jpg');
instrTexture = Screen('MakeTexture', window, instruction);
Screen('DrawTexture', window, instrTexture, [], [], 0);
Screen('Flip', window);
pause(.5)
KbWait();

instruction = imread('Pratice.jpg');
instrTexture = Screen('MakeTexture', window, instruction);
Screen('DrawTexture', window, instrTexture, [], [], 0);
Screen('Flip', window);
pause(.5)
KbWait();


catch ME2
end

order = randperm(96);
cues = [repmat({'top'},1,32), repmat({'bottom'},1,32),repmat({'none'},1,32)];
cues = cues(order);
arrows = repmat({'L_L','L_R','R_R','R_L'},1,24);
arrows = arrows(order);
arrowplace = repmat({'top','top','top','top','bottom','bottom','bottom','bottom'},1,12);
arrowplace = arrowplace(order)
cue_top = [xCenter-50, yCenter-200, xCenter+50, yCenter-100];
cue_bottom = [xCenter-50, yCenter+100, xCenter+50, yCenter+200]; 
arrow_top = [xCenter-300, yCenter-200, xCenter+300, yCenter-100];
arrow_bottom = [xCenter-300, yCenter+100, xCenter+300, yCenter+200];




try
    
for i = [1 15 20 30 40 19 70 22]
    
Resp = 'none';
RT = 'NA'; %NaN

imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);


Screen('Flip', window);


Begin = GetSecs;
Time = 0;
while Time < 1.3
    Time = GetSecs - Begin;
end
imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);

if strcmp(cues(i),'top')
position= cue_top;

imagename =  strcat('cue.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], position, 0);

elseif strcmp(cues(i),'bottom')
position= cue_bottom;

imagename =  strcat('cue.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], position, 0);

end



Screen('Flip', window);

Begin = GetSecs;
Time = 0;
while Time < .1
    Time = GetSecs - Begin;
end

imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);
Screen('Flip', window);

Begin = GetSecs;
Time = 0;
while Time < .4
    Time = GetSecs - Begin;
end


if strcmp(arrowplace(i),'top')
position= arrow_top;
elseif strcmp(arrowplace(i),'bottom')
position= arrow_bottom;
end
imagename =  strcat(arrows(i),'.jpg');
image = imread(imagename{1});
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], position, 0);


imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);

Screen('Flip', window);

Begin = GetSecs;
Time = 0;
while Time < .18
    Time = GetSecs - Begin;
end

imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);
Screen('Flip', window);

Begin = GetSecs;
Time = 0;
Early = 0;

while Time < 1
    Time = GetSecs - Begin;
        [keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(RIGHT)
            RT = GetSecs - Begin;
            Early = 1;
            Resp = 'RIGHT';
            break
        elseif keyCode(LEFT)
            RT = GetSecs - Begin;
            Early = 1;
            Resp = 'LEFT';
            break
        end
end

if Early == 0
Screen('Flip', window);

Begin2 = GetSecs;
Time = 0;

while Time < 1
    Time = GetSecs - Begin2;
    [keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(RIGHT)
            RT = GetSecs - Begin;
            Resp = 'RIGHT';
            break
        elseif keyCode(LEFT)
            RT = GetSecs - Begin;
            Resp = 'LEFT';
            break
        end
end

end

if strcmp(arrows(i),'L_L')
    correct = 'LEFT';
    wrong = 'RIGHT';
    comp = 'NoComp';
elseif strcmp(arrows(i),'L_R')
    correct = 'LEFT';
    wrong = 'RIGHT';
    comp ='Comp';
elseif strcmp(arrows(i),'R_R')
    correct = 'RIGHT';
    wrong = 'LEFT';
    comp = 'NoComp';
elseif strcmp(arrows(i),'R_L')
    correct = 'RIGHT';
    wrong = 'LEFT';
    comp = 'Comp';
end

correct

if strcmp(correct, Resp)
    
    DrawFormattedText(window, 'Correct','center', 'center', white);
elseif strcmp(wrong, Resp)
    DrawFormattedText(window, 'Wrong','center', 'center', white);
end

Screen('Flip', window);
pause(1)



end


catch ME
    
end

instruction = imread('Real.jpg');
instrTexture = Screen('MakeTexture', window, instruction);
Screen('DrawTexture', window, instrTexture, [], [], 0);
Screen('Flip', window);
pause(.5)
KbWait();

for blocks = 1:2
try
    
for i = 1:96
    
Resp = 'none';
RT = 'NA';

imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);


Screen('Flip', window);


Begin = GetSecs;
Time = 0;
while Time < 1.3
    Time = GetSecs - Begin;
end
imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);

if strcmp(cues(i),'top')
position= cue_top;
imagename =  strcat('cue.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], position, 0);
elseif strcmp(cues(i),'bottom')
position= cue_bottom;
imagename =  strcat('cue.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], position, 0);
end



Screen('Flip', window);

Begin = GetSecs;
Time = 0;
while Time < .1
    Time = GetSecs - Begin;
end

imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);
Screen('Flip', window);

Begin = GetSecs;
Time = 0;
while Time < .4
    Time = GetSecs - Begin;
end
if strcmp(arrowplace(i),'top')
position= arrow_top;
elseif strcmp(arrowplace(i),'bottom')
position= arrow_bottom;
end
imagename =  strcat(arrows(i),'.jpg');
image = imread(imagename{1});
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], position, 0);

imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);

Screen('Flip', window);

Begin = GetSecs;
Time = 0;
while Time < .18
    Time = GetSecs - Begin;
end

imagename =  strcat('cross.jpg');
image = imread(imagename);
imageTexture = Screen('MakeTexture', window, image);
Screen('DrawTexture', window, imageTexture, [], [xCenter-100, yCenter-100, xCenter+100, yCenter+100], 0);
Screen('Flip', window);

Begin = GetSecs;
Time = 0;
Early = 0;

while Time < 1
    Time = GetSecs - Begin;
        [keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(RIGHT)
            RT = GetSecs - Begin;
            Early = 1;
            Resp = 'RIGHT';
            break
        elseif keyCode(LEFT)
            RT = GetSecs - Begin;
            Early = 1;
            Resp = 'LEFT';
            break
        end
end

if Early == 0
Screen('Flip', window);

Begin2 = GetSecs;
Time = 0;

while Time < 1
    Time = GetSecs - Begin2;
    [keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(RIGHT)
            RT = GetSecs - Begin;
            Resp = 'RIGHT';
            break
        elseif keyCode(LEFT)
            RT = GetSecs - Begin;
            Resp = 'LEFT';
            break
        end
end

end

if strcmp(arrows(i),'L_L')
    correct = 'LEFT';
    wrong = 'RIGHT';
    comp = 'NoComp';
elseif strcmp(arrows(i),'L_R')
    correct = 'LEFT';
    wrong = 'RIGHT';
    comp ='Comp';
elseif strcmp(arrows(i),'R_R')
    correct = 'RIGHT';
    wrong = 'LEFT';
    comp = 'NoComp';
elseif strcmp(arrows(i),'R_L')
    correct = 'RIGHT';
    wrong = 'LEFT';
    comp = 'Comp';
end

correct

if strcmp(correct, Resp)
    
    DrawFormattedText(window, 'Correct','center', 'center', white);
elseif strcmp(wrong, Resp)
    DrawFormattedText(window, 'Wrong','center', 'center', white);
end

Screen('Flip', window);
pause(1)


fprintf(CSVfile, '%s,%s,%s,%s,%s,%s,%d\n', cues{i}, arrows{i},arrowplace{i}, Resp,comp, correct,RT);


end


catch ME
    
end

DrawFormattedText(window, 'Please tke a short break, then press spacebar to continue.',...
    'center', 'center', white);
Screen('Flip', window);
KbWait();
end


DrawFormattedText(window, 'End of Task. Please notify the experimenter.  ',...
    'center', 'center', white);
Screen('Flip', window);
pause(.5)
KbWait();
sca;
