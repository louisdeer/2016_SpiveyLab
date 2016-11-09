%function
function[c, d] = myfuncName(a,b)
c=a+b
d=a-b

CSVfile = fopen('Test.txt', 'w');

fprintf(CSVfile, '%s','Cue,/n');

fclose('Test.txt');
end
%use [k,s] = myfuncName to get both values