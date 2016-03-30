$(document).ready(function(){
  function showModal() {
    $('.modal-link').on("click", function(e) {
      e.preventDefault();
      $('.modal').addClass('is-visible');
    });
  }

  function hideModal() {
    $('.modal .close-btn, .modal .close-link, .modal .add-to-cart').on("click", function(e) {
      e.preventDefault();
      $('.modal').removeClass('is-visible');
    });
  }

  showModal();
  hideModal();
});
