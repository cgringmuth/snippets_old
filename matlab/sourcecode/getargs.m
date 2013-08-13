function [errorid,errormsg,varargout]=getargs(argnames,defaultargs,varargin)
%getargs returns the given parameter in vararging with the same order as provided in
%argnames. Returns default arguments it not other provided
%   Usage:
%   [errorid,errormsg,muh,foo,foobar]=getargs({'muh', 'foo', 'foobar'},{'a', 1, 'bl'},{'foo',-2, 'muh', 'yz'})
%   errorid = 0
%   errormsg = ''
%   muh = yz
%   foo = -2
%   foobar = bl

errorid=0;
errormsg='';
varargout=defaultargs;
nargs=length(varargin);

% must have name/value pairs
if mod(nargs,2)~=0
  errorid = 1;
  errormsg = 'Wrong number of arguments.';
  
elseif numel(varargout) ~= numel(argnames)
  errorid = 3;
  errormsg = 'defaultargs has to as number of argnames';  
  
else
  for n = 1:2:nargs
    argname = varargin{n};
    
    % check if argname is char
    if ~ischar(argname)
      errorid = 2;
      errormsg = 'Argument name has to be string/char.';
      break   % skip to next argnument
    end
    
    % get index for varargout
    idx = find(strcmp(argname, argnames));
    if isempty(idx)
      errorid = 4;
      errormsg = sprintf('Argument name has %s could not be found in argnames.', argname);      
      break   % skip to next argument
    end   % if
    
    varargout{idx} = varargin{n+1};
    
  end   % for (iteration over all arguments names)
end   % if

end   % function