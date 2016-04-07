$(document).ready(function(){
  function showModal() {
    $('.modal-link').on("click", function(e) {
      e.preventDefault();
      $(this).next('.modal').addClass('is-visible');
    });
  }

  function hideModal() {
    $('.modal .close-btn, .modal .close-link').on("click", function(e) {
      e.preventDefault();
      $('.modal').removeClass('is-visible');
    });
  }

  showModal();
  hideModal();
});
