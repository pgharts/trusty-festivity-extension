function updateCategoryTypeList(html) {
  $("#festivity-types-list").replaceWith(html);
  attachListEvents();
}

function attachListEvents() {
  $('a.festivity-type').click(function(e){
    e.preventDefault();
    if (confirm("Are you sure you want to delete this Category?")){
      $.ajax({
        url: $(this).attr('href'),
        type: "DELETE",
        success: function(data, textStatus, jqXHR) {
          updateCategoryTypeList(data);
        }
      });
    }
  });
}

$(function () {
  $('button.popup').each(function(){
    Popup.setup(this);
  });

  attachListEvents();

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
        updateCategoryTypeList(data);
        Popup.close();
        $("#type_name_field").val("");
        $("#category-type-error").html("");
      },
      error: function(jqXHR, textStatus, errorThrown){
        $("#category-type-error").html(jqXHR.responseText);
      }
    });

  });

});