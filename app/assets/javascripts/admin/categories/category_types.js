$(function () {
  $('button.popup').each(function(){
    Popup.setup(this);
  });

  $('#add_type_button').click(function(e){
    e.preventDefault();
    $.post(
        $("#new_festivity_category_type").attr('action'),
        {
          name: $("#type_name_field").val(),
          site_id: $("#type_site_id").val(),
          page_class: $("#festivity_category_type_page_class").val()
        });
  });

});