function sequences_lite = config_sequences_lite
%CONFIG_SEQUENCES_LITE
    cache_file = fullfile(get_global_variable('toolkit_path'), 'cache', 'sequences_lite_cache.mat');
    if exist(cache_file, 'file')
        fprintf('Load cache file %s\n', cache_file);
        load(cache_file);
        return;
    else
        error('No cache file.');
    end
end

