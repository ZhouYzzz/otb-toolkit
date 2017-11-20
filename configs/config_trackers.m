function trackers = config_trackers

% Register state-of-the-art trackers
register('trackers', struct('name','MDNet','namePaper','MDNet'));
register('trackers', struct('name','CCOT','namePaper','CCOT'));
register('trackers', struct('name','SRDCFdecon','namePaper','SRDCFdecon'));
register('trackers', struct('name','HDT','namePaper','HDT'));
register('trackers', struct('name','Staple','namePaper','Staple'));
register('trackers', struct('name','SRDCF','namePaper','SRDCF'));
register('trackers', struct('name','DeepSRDCF','namePaper','DeepSRDCF'));
register('trackers', struct('name','CNN-SVM','namePaper','CNN-SVM'));
register('trackers', struct('name','CF2','namePaper','CF2'));
register('trackers', struct('name','LCT','namePaper','LCT'));
register('trackers', struct('name','DSST','namePaper','DSST'));
register('trackers', struct('name','MEEM','namePaper','MEEM'));
register('trackers', struct('name','KCF','namePaper','KCF'));
register('trackers', struct('name','SAMF','namePaper','SAMF'));

% Register local trackers
% 'name': the identifier of the tracker
% 'namePaper': the name of tracker's repository, you can put multiple verisons of tracker in a single repository
% 'mainFunc': the main entrance of your tracker subject to the protocol of OTB
% 'setupFunc': the function to initialize the environment
register('trackers', struct('name','Example','namePaper','Example','mainFunc','run_Example','setupFunc',';'));
%register('trackers', struct('name','ECO','namePaper','ECO','mainFunc','OTB_DEEP_settings','setupFunc','setup_paths'));
%register('trackers', struct('name','ECO-HC','namePaper','ECO','mainFunc','OTB_HC_settings','setupFunc','setup_paths'));

trackers = register('trackers');
register('trackers', 'clear');
end
