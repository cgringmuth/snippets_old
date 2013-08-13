%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prealocation of structure array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 10000
b = repmat( struct('data', 0, 'name', ''), N, 1 );
% do some stuff
ctr = 1;
for ii=1:N
  newElem.data = [1 2 3];
  newElem.name = 'bla';
  b(ii) = newElem;
  ctr = ctr+1;
  if N == 1000
    break
  end
end;

% crop
b = b(1:ctr)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting lines with different color and style type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%URL: http://www.myoutsourcedbrain.com/2009/03/line-styles-in-matlab.html

%This script is for generating plots with many curves, where each curve has its own marker, color, and line style. Please see my blog post for more explanations and leave comments there.

linestyles = cellstr(char('-',':','-.','--','-',':','-.','--','-',':','-',':',...
'-.','--','-',':','-.','--','-',':','-.'));

MarkerEdgeColors=jet(n);  % n is the number of different items you have
Markers=['o','x','+','*','s','d','v','^','<','>','p','h','.',...
'+','*','o','x','^','<','h','.','>','p','s','d','v',...
'o','x','+','*','s','d','v','^','<','>','p','h','.'];

% [...]

figure
hold on
for i=1:n
  plot(X(i,:), Y(i,:),[linestyles{i} Markers(i)],'Color',MarkerEdgeColors(i,:));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save plot as vector graphic 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% http://www.mathworks.com/matlabcentral/answers/1238-font-size-changes-in-figures
% If font size is not working, try to install:
% apt-get install xfonts-75dpi
% apt-get install xfonts-100dpi

x = [line1 line2 ... lineN];
y = MappingFunc(x);

imgName = 'plot';
f = figure;
plot(x,y)	
%   saveas(gcf, [imgName,'.png'], 'png');
%   saveas(gcf, [imgName,'.eps'], 'eps'); 	% eps in b&w
%   saveas(gcf, [imgName,'.pdf'], 'pdf');	% save as pdf -> problem saves also the whit margins
saveas(gcf, [imgName,'.eps'], 'eps2c'); 	% eps with colors
close(f)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Round to n places
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function roundedNumber = roundTo(number,nPlaces)
%ROUNDTO rounds a number to n places
% SYNOPSIS: roundedNumber = roundTo(number,nPlaces)
% IN: number : the number to be rounded. Can also be an array
% nPlaces: How many places to round to. E.g. 3 will round the number to the 3rd place
% OUT: roundedNumber: number rounded to nth place
%%%%%%%%%%%%%%%%%%%%%%%%%%

% check input
if nargin < 2 || isempty(nPlaces)
error('please supply two nonempty input arguments')
end

% make multiplier
mult = 10^nPlaces;

% round
roundedNumber = round(number*mult)./mult;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function with dafault parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test(2, 4, 3, 'muh', {'bla', 1,})
test(2, [], 3, 'muh', {'bla', 1,})
test(2, 4, 3)
test(2, [], 3)
test(2)

function test(paramA, paramB, varargin)
  if ~exist('paramB','var') || isempty(paramB)
    paramB = 10;
  end
  
  if nargin>= 3
    paramC = varargin{1};
  else
    paramC = 5;
  end
  
  test2(paramA*paramB*paramC, varargin{2:end})
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calling function with variable number (varargin{:})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VARARGIN Variable length input argument list.
Allows any number of arguments to a function.  The variable
VARARGIN is a cell array containing the optional arguments to the
function.  VARARGIN must be declared as the last input argument
and collects all the inputs from that point onwards. In the
declaration, VARARGIN must be lowercase (i.e., varargin).

For example, the function,

    function myplot(x,varargin)
    plot(x,varargin{:})

collects all the inputs starting with the second input into the 
variable "varargin".  MYPLOT uses the comma-separated list syntax
varargin{:} to pass the optional parameters to plot.  The call,

    myplot(sin(0:.1:1),'color',[.5 .7 .3],'linestyle',':')

results in varargin being a 1-by-4 cell array containing the
values 'color', [.5 .7 .3], 'linestyle', and ':'.  

function printIfDebug(debug, str, varargin)

if debug
  fprintf(str, varargin{:});
end

end
% The cell array is expanded into a comma-separated list using the {:} syntax.
% http://stackoverflow.com/a/12558820/1959528




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set and Get
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Matlab supports special kinds of setter and getter functions for assigning and accessing properties that are executed whenever an attempt to set or get the corresponding property is made. Use of these is optional; they are only called if they exist. By taking this approach, we can make properties public so that clients can use the convenient dot notation, while still maintaining a level of indirection by effectively intercepting the call (although this is much slower than the regular dot notation).

We will add get and set methods for the public day property of the date class as an example. We write get followed by a dot and the property name, similarly for set .

 function day = get.day(obj)
     day = obj.day;              % We could execute other code as well.
 end
 function obj = set.day(obj,newday)
     obj.day = newday;
 end
We then assign and query the value as we did before using the dot notation, but the call is intercepted by these functions. We must take care as before to return the object in the setter methods, (as the objects are by default passed by value).

d1 = mydate(1,4,22,3,2008);   % create another mydate
day = d1.day;
d1.day = 5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% check if number is even/odd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if mod(x,2) == 0

%number is even

else

%number is odd

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate PI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The statement abs(log(-1)) is a clever way to generate
pi = abs(log(-1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamically add legends
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% http://undocumentedmatlab.com/blog/legend-semi-documented-feature/
function axh = plotCorrelationsInAxes(axh, x, y, curveName)
  if ishghandle(axh)  % check if axh is a valid axes handle to an existing graphic object
    axes(axh);
  else
    axh = axes();
  end   % if
  
  hold on
  
  h = plot(x, y, 'DisplayName',curveName);  <---
  legend('-DynamicLegend');                 <---
        
  hold off
end   % function plotCorrelationsInAxes



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How to set bits in number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All bits in number b will be set. 
% bits is an array of bit indices which specifies the bit location, starting with 1 and goes to numBit (numBit = 8 for 8 Bit numbers), 
% which should be set by v. v has to be 0 or 1.
function b = numSetBits(b, bits, v)
% NUMSETBITS set bits in b to v.
%   b has to be a number and v hast to be either 0 or 1.
%   Example: numSetBits([], [1 2 3], 1)

  % create new number if b is empty
  if isempty(b)
    b = 0;
  end
  
  % find and remove repetitions in array bits
  bits = sort(bits);
  delta = diff(bits);
  bits = bits([true delta~=0]);
  
  % set v to default value if it is not set
  if nargin < 3
    v = 1;
  end

  if v~= 0 && v~=1
    error('v has to be 0 or 1.')
  end

  bits = sum(bitshift(1, bits-1));
  if v==1
    b = bitor(b, bits);
  else
    b = bitxor(b, bitand(b, bits));
  end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some error functions to throw
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------
%% throwNotKnownWeightingMethodError
function throwNotKnownWeightingMethodError(weightingMethod)
error(['stats:' mfilename ':NotKnownWeightingMethodError'], ...
      '%s: Weighting method %d is not known.', upper(mfilename), weightingMethod);
end


%-----------------------------
%% throwUndefinedError
function throwUndefinedError()
st = dbstack;
name = regexp(st(2).name,'\.','split');
error(['stats:' mfilename ':UndefinedFunction'], ...
      'Undefined function or method ''%s'' for input arguments of type ''%s''.',name{2},mfilename);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OOP calling super constructor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef wSalDiffMethod1 < wSalDiffMethodAbstract
%WSALDIFFMETHOD1 Summary of this class goes here
%   Detailed explanation goes here
  
%% properties
properties

end   % properties (public)

%% methods  (public)
methods
  
  %% constructor
  function obj = wSalDiffMethod1(pmm, imManager)
    obj = obj@wSalDiffMethodAbstract(pmm, imManager);   % call super constructor
  end   % function (constructor)
  .....

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to get numVals in the range [startVal, endVal] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function v = getValues(startVal, endVal, numVal)
%getValues returns an array v of values between startVal and endVal which
%is of size numVal.
steps = double(endVal-startVal)/(numVal-1);
v = startVal:steps:endVal;
end