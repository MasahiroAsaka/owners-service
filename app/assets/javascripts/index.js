$(document).on('turbolinks:load',function(){
  var $win = $(window);
  var $navBar = $('.sticky');
  $win.on('load scroll', function() {
    var value = $(this).scrollTop();
    if (value < 92){
      $navBar.css('top', - 92 + value)
   }else if (value > 92){
      $navBar.css('top', 0)
   }
  });
});
