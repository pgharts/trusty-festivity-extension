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
    alert("Clicked!");
  }

};