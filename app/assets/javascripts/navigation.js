
function toggleNavWrapper() {
  var $menuTrigger = $('.menu-trigger'),
    $navWrapper = $('.nav-wrapper'),
    $iconMenuButton = $('.iconmenu-button');

  $menuTrigger.on("click", function(e) {
    $menuTrigger.toggleClass('is-active');
    $iconMenuButton.toggleClass('open');
    $navWrapper.slideToggle("fast").toggleClass('is-visible');
  });
};

$(document).ready(function(){
  var $menuTrigger = $('.menu-trigger'),
    $navWrapper = $('.nav-wrapper'),
    $primaryMenu = $('.primary-navigation'),
    $utilityMenu = $('.utility-navigation'),
    $iconMenuButton = $('.iconmenu-button');
// Fixes broken navigation when changing states on mobile then expanding to desktop
  jRes.addFunc({
    breakpoint: 'nav',
    enter: function() {
      $primaryClone = $primaryMenu.clone().addClass('clone');
      $primaryMenu.hide();
      $primaryClone.insertBefore($utilityMenu);
    },
    exit: function(){
      $navWrapper.removeClass('is-visible').removeAttr('style');
      $menuTrigger.removeClass('is-active');
      $iconMenuButton.removeClass('open');
      $primaryClone.remove();

      if (!$primaryMenu.is(':visible')) {
        $primaryMenu.show();
      }
    }
  });
  toggleNavWrapper();
});


