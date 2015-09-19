Festivity.Categories = {
  bindEvents: function(category){
    this.bindFormEvents();
    this.bindListEvents(category);
  },

  bindFormEvents: function() {
    $('#popup_window .buttons .cancel, .popup .buttons .cancel').unbind("click");
    $('#popup_window .buttons .cancel, .popup .buttons .cancel').click(function(e) {
      e.preventDefault();
      Popup.close();
    });
    $('input[data-role="add_category"]').unbind("click");
    $('input[data-role="add_category"]').click(function(e){
      e.preventDefault();
      var category =  $(this).attr('data-category');
      $.ajax({
        url: $("#new_" + category).attr('action'),
        type: 'POST',
        data: {
          name: $("#" + category + "_name_field").val(),
          category_type_id: $("#" + category + "_type_id").val(),
          parent_id: $("#" + category + "_parent_id").val()
        },
        success: function(data, textStatus, jqXHR){
          Festivity.Categories.updateCategoryLists(data, category);
          Popup.close();
          $("#" + category + "_name_field").val("");
          $("#category-type-error").html("");
        },
        error: function(jqXHR, textStatus, errorThrown){
          $("#category-type-error").html(jqXHR.responseText);
        }
      });

    });
  },

  bindListEvents: function(category) {
    $('a.festivity-delete-category').unbind("click");
    $('a.festivity-delete-category').click(function(e){
      e.preventDefault();
      var category =  $(this).attr('data-category');
      if (confirm("Are you sure you want to delete this Category?")){
        $.ajax({
          url: $(this).attr('href'),
          type: "DELETE",
          success: function(data, textStatus, jqXHR) {
            Festivity.Categories.updateCategoryLists(data, category);
          }
        });
      }
    });

    if(category == null) {
      $('#festivity-filters li a:first').tab('show');
    }
    else {
      $('#festivity-filters a[href="#' + category + '"]').tab('show');
    }
    $(".category-table").treetable();
  },

  updateCategoryLists: function(html, category) {
    popupHtml = $(html).siblings(".new-category-popup").html();
    $(html).siblings(".new-category-popup").remove();
    $("#festivity-filters").replaceWith(html);
    if(popupHtml != undefined) {
      $("#add_" + category + "_popup").replaceWith(popupHtml);
    }
    Festivity.CategoryTypes.bindPopupEvents();
    this.bindEvents(category);
  }
};