function OPE_drawplot(sequences, trackers, linespecs)
% perfmat (nTrk, nSeq) cell of [1 x nPts]

evalType = 'OPE';

toolkit_path = get_global_variable('toolkit_path');
results_path = fullfile(toolkit_path, 'results', 'OPE');
perfmat_path = fullfile(toolkit_path, 'perfmat', 'OPE');
figure_path = fullfile(toolkit_path, 'figs', 'OPE');

nseq = length(sequences);
ntrk = length(trackers);

thresholdSetOverlap = 0:0.05:1;
thresholdSetError = 0:50;

% load the perfmat
perfmat_file = fullfile(perfmat_path, ['perfplot_curves_' evalType '.mat']);
load(perfmat_file); %'success_curve','precision_curve','nameTrkAll'

% Ranking the trackers
AUC = cellfun(@mean, success_curve);
AUC = mean(AUC, 2); % the AUC of each tracker
for itrk = 1:ntrk
    nameTrkAll{itrk} = [nameTrkAll{itrk} ' [' num2str(AUC(itrk),'%.3f') ']'];
end
[~, rank] = sort(AUC, 'descend');

% cell2array
success = reshape(cell2mat(success_curve), ntrk, length(thresholdSetOverlap), nseq);
precision = reshape(cell2mat(precision_curve), ntrk, length(thresholdSetError), nseq);
success = squeeze(mean(success,3));

h = figure; hold on;
for itrk = rank'
    plot(thresholdSetOverlap, success(itrk,:), linespecs{itrk}); hold on;
end

legend(nameTrkAll(rank), 'Location', 'southwest');
box on;
title('Success plots of OPE');
xlabel('Overlap threshold');
ylabel('Success rate');
saveas(h,fullfile(figure_path, 'success_plot'),'png');
end

