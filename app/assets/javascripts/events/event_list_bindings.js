$(document).ready(function() {
    var $toggler = $('.toggler-root')
    $togglerTrigger = $('.toggler-trigger'),
        parentClass = "content-expanded",
        expandedClass = "is-expanded",
        $sidebarFilters = $('.menu-content-wrapper > .filters-wrapper');

    function toggler() {
        $togglerTrigger.on("click", function(e) {
            e.preventDefault();

            var content = $(this).next();

            if (content.hasClass(expandedClass)) {
                contentCollapse(content);
                $(this).attr('aria-expanded', false)
                content.attr('aria-hidden', true);
            } else {
                contentExpand(content);
                $(this).attr('aria-expanded', true)
                content.attr('aria-hidden', false);
            }
        });
    };

    function contentExpand(content) {
        content.parent().addClass(parentClass);
        content.addClass(expandedClass).stop().slideDown();
    };

    function contentCollapse(content) {
        content.parent().removeClass(parentClass);
        content.removeClass(expandedClass).stop().slideUp();
    };

    toggler();

    $('.show-filters-trigger').on('click', function(e){
        e.preventDefault();
        $('.overflow-wrapper').addClass('show-filters');
    });

    $('.overflow-wrapper').on('click', function(event){
        if(!$(event.target).is($('.show-filters-trigger'))){
            hideFiltersWhenClickedOutside(event);
        }
    });

    $sidebarFilters.find('.submit-filters').on('click', function(e){
        $('.overflow-wrapper').removeClass('show-filters');
    });

    $sidebarFilters.find('.cancel-filters').on('click', function(e){
        $('.overflow-wrapper').removeClass('show-filters');
    });


    function hideFiltersWhenClickedOutside(click){
        var target = click.target;
        var filters = $('.filters-wrapper');
        var isDescendant = $(target).parents('.filters-wrapper').length > 0;

        // if the click's target is not a descendant of the filter wrapper
        if(!(isDescendant || $(target).is(filters)) && $('.overflow-wrapper').hasClass('show-filters')){
            $('.overflow-wrapper').removeClass('show-filters');
        }
    }
    Festivity.Filters.bindEvents();
});