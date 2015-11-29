Festivity.Filters = {
  parentClass: function(){ return "content-expanded"},
  expandedClass: function(){ return "is-expanded"},
  togglerTrigger: function(){ return $('.toggler-trigger')},
  toggler: function() {
    Festivity.Filters.togglerTrigger().off("click");
    Festivity.Filters.togglerTrigger().on("click", function(e) {
      e.preventDefault();

      var content = $(this).next();

      if (content.hasClass(Festivity.Filters.expandedClass())) {
        Festivity.Filters.contentCollapse(content);
        $(this).attr('aria-expanded', false)
        content.attr('aria-hidden', true);
      } else {
        Festivity.Filters.contentExpand(content);
        $(this).attr('aria-expanded', true)
        content.attr('aria-hidden', false);
      }
    });
  },
  contentExpand: function(content) {
    content.parent().addClass(Festivity.Filters.parentClass());
    content.addClass(Festivity.Filters.expandedClass()).stop().slideDown();
  },

 contentCollapse: function(content) {
    content.parent().removeClass(Festivity.Filters.parentClass());
    content.removeClass(Festivity.Filters.expandedClass()).stop().slideUp();
  },
  bindEvents: function() {
    Festivity.Filters.toggler();
    $(".date-filters input[type='checkbox'], .category-filters input[type='checkbox']").click(function(e){
      if (e.target.checked == false) {
        $("input[data-sort='" + $(e.target).attr("data-sort") + "']").removeAttr('checked');
      }
      else {
        $("input[data-sort='" + $(e.target).attr("data-sort") + "']").attr('checked', true);
      }
      Festivity.Filters.queryEvents();
    });

    $("#clear-filters").click(function(e){
      e.preventDefault();
      $("input[type='checkbox']").removeAttr("checked");
      Festivity.Filters.queryEvents();
    });

    $("#sort").change(function(e){
      $("#sort").val(e.currentTarget.value);
      Festivity.Filters.queryEvents();
    });

    $( document ).ajaxStart(function() {
      $("i#spinner").removeClass('hide');
      $('input[type="checkbox"]').attr('disabled', true);
      $('select').attr('disabled', true);
    });

    $( document ).ajaxStop(function() {
      $('input[type="checkbox"]').removeAttr('disabled');
      $('select').removeAttr('disabled');
      $("i#spinner").addClass('hide');
    });
    Festivity.Filters.bindListEvents();
    Festivity.Filters.toggleClearButton();
    Festivity.Filters.updateActiveFilters();
  },

  bindListEvents: function() {
    // init popovers
    $("[data-toggle=popover]").popover();
  },

  toggleClearButton: function() {
    if($("input[type='checkbox']:checked").length > 0) {
      $("#current-filters").removeClass("hide");
    }
    else {
      $("#current-filters").addClass("hide");
    }
  },

  queryEvents: function() {
    var url = Festivity.Filters.eventsUrl();
    history.pushState(null, "A new title!", url);
    $.ajax({
      url: url,
      cache: false,
      type: "GET",
      success: function(data, textStatus, jqXHR){
        $("section.events-group").html(data);
        Festivity.Filters.bindListEvents();
        Festivity.Filters.toggleClearButton();
        Festivity.Filters.updateActiveFilters();
        Festivity.Filters.toggler();
      }
    });
  },

  updateActiveFilters: function() {
    var filter_types = _.uniq(_.map($("input[type='checkbox']:checked"), Festivity.Filters.checkboxFilterType));
    $("#current-filters-list").html(filter_types.join(", "))
  },

  eventsUrl: function() {
    var dates = _.map($(".date-filters input[type='checkbox']:checked"), Festivity.Filters.checkboxValues);
    var categories = _.map($(".category-filters input[type='checkbox']:checked"), Festivity.Filters.checkboxValues);
    var sort_string = "?sort=" + $("#sort").val();
    var params_string = Festivity.Filters.arrayToParams("dates", _.uniq(dates)) + Festivity.Filters.arrayToParams("categories", _.uniq(categories));
    return $("#events-url").val() + sort_string + params_string;
  },

  checkboxValues: function(checkbox) {
    return $(checkbox).val();
  },

  checkboxFilterType: function(checkbox) {
    return $(checkbox).attr('data-filter');
  },

  arrayToParams: function(param, array) {
    if (array.length > 0) {
      return "&" + param + "=" + array.join(",");
    }
    else {
      return "";
    }
  }

};