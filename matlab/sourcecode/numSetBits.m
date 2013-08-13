function b = numSetBits(b, bits, v)
%NUMSETBITS set bits in b to v.
%   b has to be a number and v hast to be either 0 or 1.
%   Usage: 
%   b = numSetBits([], [1 2 3], 1);
%   will return a number where bit 1 2 3 are set to 1, to unset this bits 
%   the function has to be called as follows:
%   b = numSetBits(b, [1 2 3], 0);

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