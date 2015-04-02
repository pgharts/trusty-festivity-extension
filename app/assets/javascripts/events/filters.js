Festivity.Filters = {
  bindEvents: function() {
    $(".date-filters input[type='checkbox'], .category-filters input[type='checkbox']").click(function(){
      Festivity.Filters.queryEvents();
    });

    $(".sort-control").change(function(e){
      $(".sort-control").val(e.currentTarget.value);
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
  },

  bindListEvents: function() {
    // init popovers
    $("[data-toggle=popover]").popover();
  },

  queryEvents: function() {
    var url = Festivity.Filters.eventsUrl();
    history.pushState(null, "A new title!", url);
    $.ajax({
      url: url,
      type: "GET",
      success: function(data, textStatus, jqXHR){
        $("#event-list-items").html(data);
        Festivity.Filters.bindListEvents();
      }
    });
  },

  eventsUrl: function() {
    var dates = _.map($(".date-filters input[type='checkbox']:checked"), Festivity.Filters.checkboxValues);
    var categories = _.map($(".category-filters input[type='checkbox']:checked"), Festivity.Filters.checkboxValues);
    var sort_string = "?sort=" + $("#sort").val();
    var params_string = Festivity.Filters.arrayToParams("dates", dates) + Festivity.Filters.arrayToParams("categories", categories);
    return $("#events-url").val() + sort_string + params_string;
  },

  checkboxValues: function(checkbox) {
    return $(checkbox).val();
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