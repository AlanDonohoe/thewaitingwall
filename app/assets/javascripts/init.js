(function($){ 
  $(function(){
    
  // media queries image swap
    var imgsmall = "(min-device-width:320px)";
    var imgbig   = "(min-device-width:960px)";
    function imageresize() {
      if(window.matchMedia(imgbig).matches) {
        $('.change img').each(function () {
            this.src= "/assets/background2-6492c83fc5943157d9debcd80089e7f7.jpg";
        });
        // swap out small displays for xs displays on smaller screens
        $('.display').removeClass('XS');
        $('.display').addClass('S');
        $('.flapper').css('font-weight', 800);
      }
      else if(window.matchMedia(imgsmall).matches) {
        $('.change img').each(function () {
            this.src= "/assets/background1-a9d15ff618c71c16cc1cc81dc8d8f2f1.jpg";
        });
        // swap out small displays for xs displays on smaller screens
        $('.display').removeClass('S');
        $('.display').addClass('XS');
        $('.flapper').css('font-weight', 300);
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