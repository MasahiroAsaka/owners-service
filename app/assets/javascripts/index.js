$(document).on('turbolinks:load',function(){
  var $win = $(window);
  var $navBar = $('.sticky');
  $win.on('load scroll', function() {
    var value = $(this).scrollTop();
    if (value < 92){
      $navBar.css('display', 'none');
    }else if (value > 92){
      $navBar.css({'display':'block'
                  ,'height':'58px'
                  ,'width':'100%'
                  ,'position':'fixed'
                  ,'top':'0px'
                  ,'z-index':'1000'}
                  );
    }
  });
});
