function startup
clear all; close all; clc; warning off all;

[pathstr, name, ext] = fileparts(mfilename('fullpath'));

addpath(fullfile(pathstr, 'utils'));
addpath(fullfile(pathstr, 'configs'));
addpath(fullfile(pathstr, 'evals'));
set_global_variable('toolkit_path', pathstr);

% reuse functions from old repository
addpath(fullfile(pathstr, 'tracker_benchmark_v1.0', 'util'));
addpath(fullfile(pathstr, 'tracker_benchmark_v1.0', 'rstEval'));

% mkdir
mkdir(fullfile(pathstr, 'cache'));
end

