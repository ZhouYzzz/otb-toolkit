function sequences = config_sequences
%CONFIG_SEQUENCES
    seqspath = fullfile(get_global_variable('toolkit_path'), 'sequences');
    cache_file = fullfile(get_global_variable('toolkit_path'), 'cache', 'sequences_cache.mat');
    lite_cache_file = fullfile(get_global_variable('toolkit_path'), 'cache', 'sequences_lite_cache.mat');

    if exist(cache_file, 'file')
        fprintf('Load cache file %s\n', cache_file);
        load(cache_file);
        return;
    end

    fid = fopen(fullfile(seqspath, 'SEQUENCES'), 'r');
    while true
        sequence_name = fgetl(fid);
        if (sequence_name == -1), break; end;
        if ~exist(fullfile(seqspath, sequence_name), 'dir')
            download_if_needed(seqspath, sequence_name);
        end
        register('sequences', get_sequence(seqspath, sequence_name));
    end
    fclose(fid);

    sequences = register('sequences');

    save(cache_file, 'sequences');

    for i = 1:length(sequences)
        register('sequences_lite', struct('name', sequences{i}.name, 'annos', sequences{i}.annos));
    end

    sequences_lite = register('sequences_lite');

    save(lite_cache_file, 'sequences_lite');

    register('sequences', 'clear');
    register('sequences_lite', 'clear');
end

function s = get_sequence(seqspath, sequence)
    s = struct();
    % NAME (identifier)
    s.name = sequence;
    % PATH (the dir containing the sequence's files)
    s.path = fullfile(seqspath, sequence);
    % ANNO_FILE
    anno_filename = 'groundtruth_rect.txt';
    splitted = strsplit(sequence, '-');
    if length(splitted) == 2, anno_filename = strrep(anno_filename, '.', ['.' splitted{2} '.']); end;
    s.anno_file = fullfile(s.path, anno_filename);
    % NZ (num of zeros)
    s.nz = 4;
    % EXT
    s.ext = 'jpg';
    % STARTFRAME
    s.startFrame = 1;
    % ANNOS (annotations)
    s.annos = dlmread(s.anno_file);
    % ENDFRAME
    s.endFrame = size(s.annos, 1);
    % SPECIAL_CASES
    if (strcmp(sequence, 'Board')), s.nz = 5; end;
    if (strcmp(sequence, 'David')), s.startFrame = 300; s.endFrame = 770; end;
    if (strcmp(sequence, 'Football1')), s.endFrame = 74; end;
    if (strcmp(sequence, 'Freeman3')), s.endFrame = 460; end;
    if (strcmp(sequence, 'Freeman4')), s.endFrame = 283; end;
    if (strcmp(sequence, 'BlurCar1')), s.startFrame = 247; s.endFrame = 988; end;
    if (strcmp(sequence, 'BlurCar3')), s.startFrame = 3; s.endFrame = 359; end;
    if (strcmp(sequence, 'BlurCar4')), s.startFrame = 18; s.endFrame = 397; end;
    if (strcmp(sequence, 'Tiger1')), s.startFrame = 6; s.endFrame = 354; s.annos = s.annos(s.startFrame:s.endFrame,:); end;
    % LEN (length)
    s.len = s.endFrame - s.startFrame + 1;
    % S_FRAMES (sequence frames)
    s.s_frames = cell(s.len,1);
    fmtstr = ['%0' num2str(s.nz) 'd.' s.ext];
    for i = 1:s.len
        s.s_frames{i} = sprintf(fullfile(s.path,'img',fmtstr), s.startFrame + i - 1);
    end
end

function download_if_needed(seqspath, sequence)
    splitted = strsplit(sequence, '-');
    fprintf(['Downloading sequence ' splitted{1} ', This may take a while...\n']);
    zipname = fullfile(seqspath, 'archives', [splitted{1} '.zip']);
    zipurl = ['/home/zhouyz/Development/OTB/sequences/archive/' splitted{1} '.zip'];
    % zipurl = ['http://cvlab.hanyang.ac.kr/tracker_benchmark/seq/' splitted{1} '.zip'];
    try
        %urlwrite(zipurl, zipname);
        system(['cp ' zipurl ' ' zipname]);
        unzip(zipname, seqspath);
    catch
        fprintf('Download fails. Please try to download the bundle manually from %s and uncompress it to %s\n', zipurl, seqspath);
    end
    if length(splitted) == 2
        system(['ln -sr ' fullfile(seqspath, splitted{1}) ' ' fullfile(seqspath, splitted{1}) '-1']);
        system(['ln -sr ' fullfile(seqspath, splitted{1}) ' ' fullfile(seqspath, splitted{1}) '-2']);
    end
end

