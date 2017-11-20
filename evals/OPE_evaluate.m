function OPE_evaluate(sequences, trackers)
    for iseq = 1:length(sequences)
        for itrk = 1:length(trackers)
            fprintf('%5d_%-12s,%3d_%-20s\n',iseq,sequences{iseq}.name,itrk,trackers{itrk}.name);
            OPE(sequences{iseq}, trackers{itrk});
        end
    end
end

function OPE(s, t)
%OPE(SEQUENCE, TRACKER)
% One pass evaluation (OPE). Run the TRACKER on the whole SEQUENCE once.
% Then save the results.
%
    % fprintf('%-12s - %-12s\n', s.name, t.name);
    % pre settings
    toolkit_path = get_global_variable('toolkit_path');
    evalType = 'OPE';
    tmp_path = fullfile(toolkit_path, 'tmp', evalType);
    final_path = fullfile(toolkit_path, 'results', evalType);
    result_file = fullfile(final_path, [s.name '_' t.name '.mat']);
    rp = [tmp_path s.name '_' t.name '_' num2str(1) '/'];
    bSaveImage = false;
    
    % split sequence
    numSeg = 1;
    rect_anno = s.annos;
    [subSeqs, subAnno]=splitSeqTRE(s,numSeg,rect_anno);
    subS = subSeqs{1};            
    subSeqs=[];
    subSeqs{1} = subS;
    subA = subAnno{1};
    subAnno=[];
    subAnno{1} = subA;
    
    % check results
    if exist(result_file, 'file')
        results = [];
        load(result_file);
        bfail=checkResult(results, subAnno);
        if ~isempty(results), return; end;
        %if ~bfail
        %    return; % exit now
        %end
    end

    % the tracker's path
    tracker_path = fullfile(toolkit_path, 'trackers', t.namePaper);
    if ~exist(tracker_path, 'dir')
        error(['Fail to find tracker repository: ' tracker_path]);
    end

    % the main function to excute
    func = ['res = ' t.mainFunc '(subS, rp, bSaveImage);'];

    results = [];
    try
        % setup before excution
        old_path = path; % save search path state
        cd(tracker_path);
        eval(t.setupFunc);

        % main running
        eval(func);

        % cleanup after excution
        path(old_path); % restore search path state
        cd(toolkit_path);
    catch err
        disp(getReport(err));
        % save err;
        err.sname = s.name;
        err.tname = t.name;
        register('errors', err);
        % cleanup after error
        rmpath(genpath('./'));
        cd(toolkit_path);
        % continue;
    end
    res.len = subS.len;
    res.annoBegin = subS.annoBegin;
    res.startFrame = subS.startFrame;
    results{1} = res;

    save(result_file, 'results');
end

