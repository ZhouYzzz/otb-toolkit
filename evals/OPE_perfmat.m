function OPE_perfmat(sequences, trackers)

evalType = 'OPE';

toolkit_path = get_global_variable('toolkit_path');
results_path = fullfile(toolkit_path, 'results', 'OPE');
perfmat_path = fullfile(toolkit_path, 'perfmat', 'OPE');

nseq = length(sequences);
ntrk = length(trackers);

% names of all the trackers evaluated
nameTrkAll = {};
for i = 1:ntrk
    nameTrkAll{end+1} = trackers{i}.name;
end

success_curve = cell(ntrk, nseq);
precision_curve = cell(ntrk, nseq);

for iseq = 1:nseq
    for itrk = 1:ntrk
        fprintf('%5d_%-12s,%3d_%-20s\n',iseq,sequences{iseq}.name,itrk,trackers{itrk}.name);
        [success, precision] = perf(sequences{iseq}, trackers{itrk}, results_path);
        success_curve{itrk, iseq} = success;
        precision_curve{itrk, iseq} = precision;
    end
end

% save result file
perfmat_file = fullfile(perfmat_path, ['perfplot_curves_' evalType '.mat']);
save(perfmat_file,'success_curve','precision_curve','nameTrkAll');

end % function OPE_perfmat

function [success, precision] = perf(s, t, results_path)
    % threshold sampled in the plots
    thresholdSetOverlap = 0:0.05:1;
    thresholdSetError = 0:50;

    % load results
    results_file = fullfile(results_path, [s.name '_' t.name '.mat']);
    load(results_file);

    anno = s.annos;

    % preparing evaluation
    aveCoverageAll=[];
    aveErrCenterAll=[];
    errCvgAccAvgAll = 0;
    errCntAccAvgAll = 0;
    errCoverageAll = 0;
    errCenterAll = 0;
    
    successNumOverlap = zeros(1,length(thresholdSetOverlap));
    successNumErr = zeros(1,length(thresholdSetError));
    idx = 1;
    res = results{idx};
    len = size(anno,1);
    
    if isempty(res.res)
        error('DUBUG ENTER 1');
        return;
    end
    
    if ~isfield(res,'type')&&isfield(res,'transformType')
        error('DUBUG ENTER 2');
        res.type = res.transformType;
        res.res = res.res';
    end
    
    [aveCoverage, aveErrCenter, errCoverage, errCenter] = calcSeqErrRobust(res, anno);
    
    for tIdx=1:length(thresholdSetOverlap)
        successNumOverlap(idx,tIdx) = sum(errCoverage > thresholdSetOverlap(tIdx));
    end
    
    for tIdx=1:length(thresholdSetError)
        successNumErr(idx,tIdx) = sum(errCenter <= thresholdSetError(tIdx));
    end

    success = successNumOverlap/(len+eps);
    precision = successNumErr/(len+eps);
end % function perf

