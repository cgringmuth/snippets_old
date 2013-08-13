classdef PrintMsgManager < handle   % derive from handel to ensure call-by-reference
% PrintMsgManager manages outputs on screen/file/variable accordingly to
% loglevel variable
%   This class can be used to write and save outputs on screen/file.
%   Additionally it manages a variable which stores the log history. 
%   
%   Example: 
%   Creating Object
%   logging = PrintMsgManager.none; % if nothing should be printed
%   logging = bitor(logging, PrintMsgManager.information);  % add information
%   logging = bitor(logging, PrintMsgManager.debug);  % add debug
%   logging = bitor(logging, PrintMsgManager.verbose);  % add verbose to print
%   pmm = PrintMsgManager(obj, logging);  % if PrintMsgManager is created
%   from object "obj". otherwise use the following
%   pmm = PrintMsgManager(PrintMsgManager.parentMain, logging);  
%   to get an logging manager which displays everything plus debuging
%   information
%
%   Usage examples:
%   pmm.print(PrintMsgManager.verbose, '%s: start calculating correlation\n', mfilename);
%   pmm.print(PrintMsgManager.information, '%s: start calculating correlation\n', mfilename);
%   pmm.print(PrintMsgManager.debug, '%s: start calculating correlation\n', mfilename);
  
%% * properties(Constant=true)
properties(Constant=true)
  parentMain = 'main.function';
  none = 0;
  debug = numSetBits(0,1,1);  % only show message for debug
  information = numSetBits(0,2,1); % show important outputs like important numbers
  verbose = numSetBits(0,3,1); % show workflow
end   % properties (public, constant)

%% * methods(Static)
methods(Static)
  
  %% function t = getTimeStamp
  function t = getTimeStamp
    c = clock;
    
    t = sprintf('[%d:%d:%02d]', c(4), c(5), round(c(6)));
  end   % function
  
  %% function st = runtests()
  function st = runtests()
    clc
    clear
    
    st = 0;
    filename='';  % todo: test this with file
    locPrintFuncName=true;
    
    % logging status "none"
    logging = PrintMsgManager.none; % if nothing should be printed
    st = st + PrintMsgManager.testLoggingLevel(logging, filename, locPrintFuncName);
    
    % logging status "information"
    logging = PrintMsgManager.information; 
    st = st + PrintMsgManager.testLoggingLevel(logging, filename, locPrintFuncName);
    
    % logging status "debug"
    logging = PrintMsgManager.debug; 
    st = st + PrintMsgManager.testLoggingLevel(logging, filename, locPrintFuncName);
    
    % logging status "verbose"
    logging = PrintMsgManager.verbose;
    st = st + PrintMsgManager.testLoggingLevel(logging, filename, locPrintFuncName);
    
    % test all logging status
    logging = PrintMsgManager.none; % if nothing should be printed
    logging = bitor(logging, PrintMsgManager.information);  % add information
    logging = bitor(logging, PrintMsgManager.debug);  % add debug
    logging = bitor(logging, PrintMsgManager.verbose);  % add verbose to print
    st = st + PrintMsgManager.testLoggingLevel(logging, filename, locPrintFuncName);    
    
    % test nargout in leveltoString
    lvl = PrintMsgManager.debug;
    strLvl1 = PrintMsgManager.leveltoString(lvl);
    [strLvl2 st_tmp] = PrintMsgManager.leveltoString(lvl);
    assert(strcmp(strLvl1, 'debug'))
    assert(strcmp(strLvl2, 'debug'))
    assert(st_tmp == 0)
    
    lvl = bitshift(PrintMsgManager.verbose, 1); % calculate loglevel which does not exist
    strLvl1 = PrintMsgManager.leveltoString(lvl);
    [strLvl2 st_tmp] = PrintMsgManager.leveltoString(lvl);
    assert(strcmp(strLvl1, 'unkown'))
    assert(strcmp(strLvl2, 'unkown'))
    assert(st_tmp ~= 0)
  end   % function runtests
  
  %% function st = testLoggingLevel(logging, filename, printFuncName)
  function st = testLoggingLevel(logging, filename, printFuncName)
    st = 0;
    lvlStr = PrintMsgManager.leveltoString(logging);
    if logging == PrintMsgManager.none
      lvlStr = 'none';
    end
    fprintf('\n$ test logging status %s\n+------------------\n', lvlStr);
    pmm = PrintMsgManager(PrintMsgManager.parentMain, logging, filename, printFuncName);
    st = st + PrintMsgManager.printAllLevel(pmm);    
  end   % function testLoggingLevel
  
  %% function st = printAllLevel(pmm)
  function st = printAllLevel(pmm)
    st = 0;
    % verbose
    fprintf('$ test to print verbose message: ');
    verboseStr = {'Test verbose mode'};
    pmm.print(pmm.verbose, verboseStr{:});
    fprintf('\n');
    
    % information
    fprintf('$ test to print information message: ');
    infoStr = {'Test information mode'};
    pmm.print(pmm.information, infoStr{:});
    fprintf('\n');
    
    % debug
    fprintf('$ test to print debug message: ');
    debugStr = {'Test debug mode'};
    pmm.print(pmm.debug, debugStr{:});
    fprintf('\n+------------------\n');
    
    % test if history works well
    fprintf('History:\n+------------------\n')
    pmm.printHistory;
    fprintf('+------------------\n');
  end   % function printAllLevel
  
  %% function [strLvl st] = leveltoString(lvl)
  function [strLvl st] = leveltoString(lvl)
  % LEVELTOSTRING returns the name of lvl.
    st_tmp  = 0;
    strLvl = 'unkown';
    lvlSeperator = '/';
    
    if bitand(lvl,PrintMsgManager.verbose)
      if strcmp(strLvl, 'unkown')
        strLvl = 'verbose';
      else
        strLvl = [strLvl, lvlSeperator, 'verbose'];
      end
    end
    
    if bitand(lvl, PrintMsgManager.debug)
      if strcmp(strLvl, 'unkown')
        strLvl = 'debug';
      else
        strLvl = [strLvl, lvlSeperator, 'debug'];
      end      
    end
    
    if bitand(lvl,PrintMsgManager.information)
      if strcmp(strLvl, 'unkown')
        strLvl = 'information';
      else
        strLvl = [strLvl, lvlSeperator, 'information'];
      end       
    end
    
    if strcmp(strLvl, 'unkown')
      warning('Level is unkown.');
      st_tmp = 1;
    end
    
    if nargout > 1
      st = st_tmp;
    end
  end   % function leveltoString
  
end   % methods (static)

%% * properties
properties
  parent;   % stores the name of the class/function which has instanciated this class to that allows to delete
  history;  % stores all data in history variable
  comDefs;  % contains all variables which are in common with other classes
  
  prefDebug='[debug]: ';
  prefInfo='[output]: ';
  prefVerbose='> ';
  
  appendStr_prefixstr = '...';
  appendStr_lvldeliminator = '\t';
  
  printFuncName;
  printTime;
  storeHist;
end   % properties (public)

%% * properties(SetAccess=private, GetAccess=private)
properties(SetAccess=private, GetAccess=private)
  logLevel;
  fid;
end   % properties (private)


%% * methods
methods
  
  %% function obj = PrintMsgManager(parent, logLevel, filename, printFuncName) [constructor]
  function obj = PrintMsgManager(parent, logLevel, filename, printFuncName, printTime, storeHist)
    
    % set default log level if it has not been set
    if nargin < 2 || isempty(logLevel)
      obj.logLevel = PrintMsgManager.information;
    else
      obj.logLevel = logLevel;
    end   % if
    
    if obj.logLevel
      % open file if filename is given
      obj.fid = -1;
      if nargin >= 3 && ~isempty(filename)
        if exist(filename, 'file')
          startStr = '\n\n';
        else
          startStr = '';
        end
        obj.fid = fopen(filename, 'a');

        if obj.fid == -1 
          warning('File %s does not exist or could not be opened.',filename);
        else
          startStr = [startStr, '===============\n', clock2Str, '\n'];
          fprintf(obj.fid, startStr);              
        end   % if   
      end   % if
    end   % if
    
    % ensure that parent contains name of class
    if ~ischar(parent)
      parent = class(parent);
    end
    % NOTE: only parent should delete this object
    obj.parent = parent;
    
    % set property obj.printFuncName to true as default
    if nargin < 4 || isempty(printFuncName)
      printFuncName = true;
    end
    obj.printFuncName = printFuncName;
    
    % init obj.history variable
    obj.history = {};
    
    if nargin < 5 || isempty(printTime) 
      printTime = true;
    end   % if
    obj.printTime = printTime;
    
    if nargin < 6 || isempty(storeHist)
      storeHist = true;
    end   % if
    obj.storeHist = storeHist;
    
    obj.comDefs = CommonDef;
  end   % function PrintMsgManager (constructor)
  
  %% function b = isParent(obj, parent)
  function b = isParent(obj, parent)
  %isParent returns true if parent is the object if parent is the object
  %which created this object.
  %   Always check before removing
    % ensure that parent contains name of class
    if ~ischar(parent)
      parentName = class(parent);
    else
      parentName = parent;
    end    
    
    b = strcmp(parentName, obj.parent);
  end   % function isParent
    
  %% function delete(obj)
  function delete(obj)
  %delete descrutor of this class.
  %   Takes care of deleting this object. Consider to check pmm.isParent(obj)
  %   to see if this object isen't used by another class. 
  %   NOTE: Only the object which has created this object should delete it.
  %         Thus, always check pmm.isParent(obj) first before invoking this
  %         function. (Assuming pmm is of instance PrintMsgManager)
    % close file if exist
    obj.print(obj.verbose, '%s: delete has been invoked\n', class(obj));
    if obj.fid ~= -1
      fclose(obj.fid);
    end
  end   % function delete (destructor) cleanup everything
  
  %% function pref = getPrefix4Lvl(obj, lvl)
  function pref = getPrefix4Lvl(obj, lvl)
    if lvl == obj.verbose
      pref = obj.prefVerbose;
    elseif lvl == obj.debug
      pref = obj.prefDebug;
    elseif lvl == obj.information
      pref = obj.prefInfo;
    else
      warning('Level is unkown.');
      pref = '';
    end
  end   % function
  
  %% function astr = appendstr(obj, str1, str2, lvl)
  function astr = appendstr(obj, str1, str2, lvl)
  %appendstr concatenates str1 and str2 with a specific manner if obj.logLevel is not set to 0.
  %   If no level (lvl) is provided or level 0 then str2 is considered as the
  %   title string with no indent. All other levels will be indent
  %   correspondingly to its level. This function guarantees, that all levels
  %   will be handled similar.
  %
  %   Usage: str = appendstr([left string], [string to be concatenated], [number of level]);
  %
  %   Example: 
  %       str = appendstr('', 'Title of string.\n');  % start string
  %       str = appendstr(str, 'properties\n', 1);
    astr = '';
    if obj.logLevel   % if obj.logLevel is equal 0 then do nothing
      if nargin < 4 || isempty(lvl)
        % define default level as 0
        lvl = 0;
      end   % if

      if lvl
        str2 = [obj.appendStr_prefixstr, repmat(obj.appendStr_lvldeliminator, 1, lvl), str2];
      end   % if

      astr = [str1, str2];
    end   % if

  end   % function
    
  %% function print(obj, lvl, msg, varargin) [main function]
  function print(obj, lvl, msg, varargin)
  %PRINT prints message to screen/file/internal history
  %   write to variable history independent of level, except if
  %   obj.logLevel is 0 (equals obj.none)
  %   Usage: obj.pmm.print(PrintMsgManager.verbose, '... initialize class %s\n', class(obj));
    if obj.logLevel   % if obj.logLevel is equal 0 then do nothing
      pref = obj.getPrefix4Lvl(lvl);
      msgStr = pref;      
      if obj.printTime
        msgStr = [obj.getTimeStamp ' ', msgStr];
      end

      if obj.printFuncName
        st = dbstack;
        callingFuncName = st(2).name;
        msgStr = [msgStr, '(@', callingFuncName ,') '];
      end

      msgStr = [msgStr, msg];

      if obj.storeHist
        % write to interval history variable
        obj = obj.print2History(lvl, msgStr, varargin{:});
      end
      
      
      % write to screen
      if bitand(lvl, obj.logLevel)
        fprintf(msgStr, varargin{:});
      end   % if 

      % write to file independent of level
      % todo: add a special logLevel for the log file
      printtofile = obj.fid~=-1;  % currently, if a file is open write to file
      if printtofile && obj.fid~=-1
        fprintf(obj.fid, msgStr, varargin{:});
      end   % if
    end   % if
  end   % function print
  
  %% function printHistory(obj, startIdx, endIdx)
  function printHistory(obj, startIdx, endIdx)
    hstr = obj.history;
    
    % set default values for startIdx and endIdx to cover complete history
    % if it is not state otherwise
    if nargin < 2 || ~isempty(startIdx), startIdx = 1; end
    if nargin < 3 || ~isempty(endIdx), endIdx = numel(hstr); end
    
    for idx = startIdx:endIdx
      fprintf('%s\n',hstr{idx});
    end   % for iteration over history
  end
  
end   % methods (public)

%% * methods (Access=private)
methods(Access=private)
  
  %% function obj = print2History(obj, lvl, msg, varargin)
  function obj = print2History(obj, lvl, msg, varargin)
    % print history to variable
    obj.history{end+1} = ['[',PrintMsgManager.leveltoString(lvl),'] ', sprintf(msg, varargin{:})];
  end
  
end   % methods (private)


end   % classdef PrintMsgManager

%% help functions

%-----------------------------
%% function str = clock2Str
function str = clock2Str
c = clock;
year = c(1);
month = c(2);
day = c(3);
hour = c(4);
sec = c(5);

str = [int2str(year) , ...
          '-' , int2str(month) , ...
          '-' , int2str(day) , ...
          ' ' , int2str(hour) , ':' , ...
          int2str(sec)
          ];
end   % function