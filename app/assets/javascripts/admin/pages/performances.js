Festivity.Performances = {
  bindEvents: function() {
    this.bindEvents();
  },

  bindEvents: function() {
    $('#add-performance').click(function(e){
      e.preventDefault();
      Festivity.Performances.addPerformance($(this).attr('href'), $(this).attr('data-id'));
    });
    Festivity.Performances.bindDateTimeMask();
    Festivity.Performances.bindDeleteEvents();

  },
  bindDateTimeMask: function() {
    $(".date_field").inputmask("festivitydatetime12");
  },
  bindDeleteEvents: function() {
    $('a.festivity-delete-performance').unbind('click');
    $('a.festivity-delete-performance').click(function(e){
      e.preventDefault();
      if (confirm("Are you sure you want to delete this performance?")){
        $.ajax({
          url: $(this).attr('href'),
          type: "DELETE",
          success: function(data, textStatus, jqXHR) {
            Festivity.Performances.updatePerformancesTable(data);
          }
        });
      }
    });
  },

  addPerformance: function(url, event_page_id){
    $.ajax({
      url: url,
      type: "POST",
      data: {
        event_page_id: event_page_id
      },
      success: function(data, textStatus, jqXHR) {
        Festivity.Performances.addPerformanceRow(data);
      }
    });
  },

  addPerformanceRow: function(data) {
    $("#festivity-performances-table").append(data);
    Festivity.Performances.bindDateTimeMask();
    Festivity.Performances.bindDeleteEvents();
  },

  updatePerformancesTable: function(data) {
    $("#festivity-performances-table").replaceWith(data);
    Festivity.Performances.bindDateTimeMask();
    Festivity.Performances.bindDeleteEvents();
  }

};
