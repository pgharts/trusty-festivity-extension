
$(function () {
  $('button.popup').each(function(){
    Popup.setup(this);
  });

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
        $("#festivity-types-list").replaceWith(data);
        Popup.close();
        $("#type_name_field").val("");
      },
      error: function(){
        alert("bye");
      }
    });

  });

});