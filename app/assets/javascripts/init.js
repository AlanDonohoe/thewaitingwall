(function($){ 
  $(function(){
    
  // media queries image swap
    var imgsmall = "(min-device-width:320px)";
    var imgbig   = "(min-device-width:960px)";
    function imageresize() {
      if(window.matchMedia(imgbig).matches) {
        $('.change img').each(function () {
            this.src= "/assets/background2.jpg";
        });
      }
      else if(window.matchMedia(imgsmall).matches) {
        $('.change img').each(function () {
            this.src= "/assets/background1.jpg";
        });
      }
    }

    imageresize();

    $(window).bind("resize", function() {
        imageresize();
    });
    $('.button-collapse').sideNav();
    $('.parallax').parallax();
  }); // end of document ready
})(jQuery); // end of jQuery name space