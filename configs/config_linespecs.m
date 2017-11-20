function linespecs = config_linespecs
    register('linespecs', get_linespec('-', 'red'));
    register('linespecs', get_linespec('-', 'green'));
    register('linespecs', get_linespec('-', 'blue'));
    register('linespecs', get_linespec('-', 'black'));
    register('linespecs', get_linespec('-', 'purple'));
    register('linespecs', get_linespec('-', 'brown'));
    register('linespecs', get_linespec('-', 'yellow'));
    register('linespecs', get_linespec('--', 'red'));
    register('linespecs', get_linespec('--', 'green'));
    register('linespecs', get_linespec('--', 'blue'));
    register('linespecs', get_linespec('--', 'black'));
    register('linespecs', get_linespec('--', 'purple'));
    register('linespecs', get_linespec('--', 'brown'));
    register('linespecs', get_linespec('--', 'yellow'));
    register('linespecs', get_linespec('-.', 'red'));
    register('linespecs', get_linespec('-.', 'green'));
    register('linespecs', get_linespec('-.', 'blue'));
    register('linespecs', get_linespec('-.', 'black'));
    register('linespecs', get_linespec('-.', 'purple'));
    register('linespecs', get_linespec('-.', 'brown'));
    register('linespecs', get_linespec('-.', 'yellow'));

    linespecs = register('linespecs');
    register('linespecs', 'clear');
end

function linespec = get_linespec(style, color)
    linespec = struct(...
        'lineWidth',    2,...
        'lineStyle',    style,...
        'color',        color,...
    );
end

