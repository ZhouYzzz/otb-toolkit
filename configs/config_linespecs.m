function linespecs = config_linespecs
    register('linespecs', get_linespec('-', 'r'));
    register('linespecs', get_linespec('-', 'g'));
    register('linespecs', get_linespec('-', 'b'));
    register('linespecs', get_linespec('-', 'y'));
    register('linespecs', get_linespec('-', 'm'));
    register('linespecs', get_linespec('-', 'c'));
    register('linespecs', get_linespec('-', 'k'));
    register('linespecs', get_linespec('--', 'r'));
    register('linespecs', get_linespec('--', 'g'));
    register('linespecs', get_linespec('--', 'b'));
    register('linespecs', get_linespec('--', 'y'));
    register('linespecs', get_linespec('--', 'm'));
    register('linespecs', get_linespec('--', 'c'));
    register('linespecs', get_linespec('--', 'k'));
    register('linespecs', get_linespec('-.', 'r'));
    register('linespecs', get_linespec('-.', 'g'));
    register('linespecs', get_linespec('-.', 'b'));
    register('linespecs', get_linespec('-.', 'y'));
    register('linespecs', get_linespec('-.', 'm'));
    register('linespecs', get_linespec('-.', 'c'));
    register('linespecs', get_linespec('-.', 'k'));

    linespecs = register('linespecs');
    register('linespecs', 'clear');
end

function linespec = get_linespec(style, color)
    linespec = struct('lineWidth', 3, 'lineStyle', style, 'color', color);
end

