Festivity.Performances = {
  bindEvents: function() {
    this.bindEvents();
  },

  bindEvents: function() {
    $('#add-performance').click(function(e){
      e.preventDefault();
      Festivity.Performances.addPerformance($(this).attr('href'), $(this).attr('data-id'));
    });
    $(".date_field").inputmask("festivitydatetime12");
  },

  addPerformance: function(url, event_page_id){
    $.ajax({
      url: url,
      type: "POST",
      data: {
        event_page_id: event_page_id
      },
      success: function(data, textStatus, jqXHR) {
        Festivity.Performances.updatePerformancesTable(data);
      }
    });
  },

  updatePerformancesTable: function(data) {

  }

};
