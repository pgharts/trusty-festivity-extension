Festivity.Filters = {
  bindEvents: function() {
    $(".date-filters input[type='checkbox'], .category-filters input[type='checkbox']").click(function(){
      Festivity.Filters.queryEvents();
    });

    $(".sort-control").change(function(e){
      $(".sort-control").val(e.currentTarget.value);
      Festivity.Filters.queryEvents();
    });

  },

  queryEvents: function() {

    alert(Festivity.Filters.eventsUrl());
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