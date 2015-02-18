function updateCategoryTypeList(html) {
  popupHtml = $(html).siblings(".new-category-popup").html();
  $(html).siblings(".new-category-popup").remove();
  $("#festivity-category-types").replaceWith(html);
  $("#popups").append(popupHtml);
  attachPopupEvents();
  attachListEvents();
  attachCategoryEvents(null);
}

function updateCategoryLists(html, category) {
  popupHtml = $(html).siblings(".new-category-popup").html();
  $(html).siblings(".new-category-popup").remove();
  $("#festivity-filters").replaceWith(html);
  if(popupHtml != undefined) {
    $("#add_" + category + "_popup").replaceWith(popupHtml);
  }
  attachPopupEvents();
  attachCategoryEvents(category);
}

function attachPopupEvents() {
  $('button.popup').each(function(){
    Popup.setup(this);
  });
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

function attachCategoryEvents(category) {
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
        updateCategoryLists(data, category);
        Popup.close();
        $("#" + category + "_name_field").val("");
        $("#category-type-error").html("");
      },
      error: function(jqXHR, textStatus, errorThrown){
        $("#category-type-error").html(jqXHR.responseText);
      }
    });

  });

  $('a.festivity-delete-category').unbind("click");
  $('a.festivity-delete-category').click(function(e){
    e.preventDefault();
    var category =  $(this).attr('data-category');
    if (confirm("Are you sure you want to delete this Category?")){
      $.ajax({
        url: $(this).attr('href'),
        type: "DELETE",
        success: function(data, textStatus, jqXHR) {
          updateCategoryLists(data, category);
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
}

$(function () {

  attachPopupEvents();
  attachListEvents();
  attachCategoryEvents(null);

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