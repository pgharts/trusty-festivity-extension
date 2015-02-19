Festivity.CategoryTypes = {
  bindEvents: function() {
    this.bindPopupEvents();
    this.bindFormEvents();
    this.bindListEvents();
  },

  bindPopupEvents: function() {
    $('button.popup').each(function(){
      Popup.setup(this);
    });
  },

  bindListEvents: function() {
    $('a.festivity-type').click(function(e){
      e.preventDefault();
      if (confirm("Are you sure you want to delete this Category?")){
        $.ajax({
          url: $(this).attr('href'),
          type: "DELETE",
          success: function(data, textStatus, jqXHR) {
            Festivity.CategoryTypes.updateCategoryTypeList(data);
          }
        });
      }
    });
  },

  bindFormEvents: function() {
    $('#add_type_button').click(function(e){
      e.preventDefault();
      $.ajax({
        url: $("#new_festivity_category_type").attr('action'),
        type: 'POST',
        data: {
          name: $("#type_name_field").val(),
          site_id: $("#type_site_id").val(),
          page_class: $("#festivity_category_type_page_class").val()
        },
        success: function(data, textStatus, jqXHR){
          Festivity.CategoryTypes.updateCategoryTypeList(data);
          Popup.close();
          $("#type_name_field").val("");
          $("#category-type-error").html("");
        },
        error: function(jqXHR, textStatus, errorThrown){
          $("#category-type-error").html(jqXHR.responseText);
        }
      });

    });
  },

  updateCategoryTypeList: function(html) {
    popupHtml = $(html).siblings(".new-category-popup").html();
    $(html).siblings(".new-category-popup").remove();
    $("#festivity-category-types").replaceWith(html);
    $("#popups").append(popupHtml);
    Festivity.CategoryTypes.bindEvents();
    Festivity.Categories.bindEvents(null);
  }

};
