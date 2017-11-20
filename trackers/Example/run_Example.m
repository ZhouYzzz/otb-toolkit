function result = run_Example(seq, rp, bSaveImage)
%RUN_EXAMPLE

    seq.s_frames; % image files
    rect = seq.init_rect; % initial rectangle [X, Y, W, H]
    num_frames = length(seq.s_frames);
    res = zeros(num_frames, 4); % record result here

    for i = 1:num_frames
        % im = imread(seq.s_frames{i}); % get frame
        res(i,:) = rect; % no displacement
    end

    result.type = 'rect';
    result.res = res;
    result.fps = 0;
    % result.XX; anything you want to record;
end

