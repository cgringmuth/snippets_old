function v = getValues(intervalRange, varargin)
%getValues returns an array v of values between startVal and endVal which
%is of size numVal.
%
%   Usage:
%   intervalRange = [1 100]; 
%   numVal = 200; 
%   v1 = getValues(intervalRange(1), intervalRange(2), numVal) 
%       - or -
%   v2 = getValues(intervalRange, numVal)

if nargin == 2
  startVal = intervalRange(1);
  endVal = intervalRange(2);
  numVal = varargin{1};
elseif nargin == 3
  startVal = intervalRange;
  endVal = varargin{1};
  numVal = varargin{2};  
end

steps = double(endVal-startVal)/(numVal-1);
v = startVal:steps:endVal;

assert(numel(v) == numVal, 'Something went wrong...')
end