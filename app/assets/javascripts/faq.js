$(document).ready(function(){
  $('.list-group-item').on('click', function(){
    $('.list-group-item').each(function(){
      $(this).removeClass('active');
    });
    $(this).addClass('active');
  });
});
