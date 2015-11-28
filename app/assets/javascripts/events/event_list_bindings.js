$(document).ready(function() {
    var $toggler = $('.toggler-root'),
        parentClass = "content-expanded",
        expandedClass = "is-expanded",
        $sidebarFilters = $('.menu-content-wrapper > .filters-wrapper');

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