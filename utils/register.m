function [set] = register(set_name, object)
%REGISTER Register an object to a internal set
%
% REGISTER(SET_NAME, OBJECT)
%   will register the OBJECT to the internal set identified as SET_NAME.
%
% REGISTER(SET_NAME, 'clear')
%   will clear all the registered obejcts.
%
% SET = REGISTER(SET_NAME, ...)
%   will return the SET containing all the registered obejcts.
%
% Input:
% - SET_NAME (string): Name of the specified set.
% - OBJECT (struct): The obejct to register.
%
% Output:
% - SET (cell, struct): An 1D cell array of structs.
%

persistent registered_sets;

if ~exist('registered_sets', 'var')
    registered_sets = struct();
end

if nargin < 1
    error('SET_NAME must be specified');
end

if ~isfield(registered_sets, set_name)
    % fprintf('create a new set named [%s]\n', set_name);
    registered_sets.(set_name) = {};
end

if nargin < 2
    set = registered_sets.(set_name);
    return;
end

if ischar(object)
    if strcmp(object, 'clear')
        registered_sets.(set_name) = {};
    else
        error(['Undefined option ' object]);
    end
else

if ~isstruct(object), error('OBJECT should be a struct'); end;

% append the object to the internal set
registered_sets.(set_name){end+1} = object;

end

set = registered_sets.(set_name);

end
