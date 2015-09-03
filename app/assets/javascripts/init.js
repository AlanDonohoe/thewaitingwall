(function($){
  $(window).load(function() {
    var loadingScreen = document.getElementById("hideAll");
    if(!!loadingScreen){
      loadingScreen.style.display = "none";
    }
  });
  $(function(){
    var calledOnce = false;
    (function hide_post_msg_btn() {
      $('#message_message_text').keyup(function(){
        value = $('#message_message_text').val().length;
        if ($('#message_message_text').val().length > 0 && !calledOnce){
          $('.fade-in').animate({ opacity: 1.0}, 1000 );
          calledOnce = true;
        }else if ($('#message_message_text').val().length < 1){
          $('.fade-in').animate({ opacity: 0.0}, 10);
          calledOnce = false;
        }
      });
    }());
    
  // media queries image swap
    var imgsmall = "(min-device-width:320px)";
    var imgbig   = "(min-device-width:960px)";
    function imageresize() {
      if(window.matchMedia(imgbig).matches) {
        // the wall
        $('.full-screen-img').css("background-image", "url(/assets/background2-6492c83fc5943157d9debcd80089e7f7.jpg) no-repeat center center fixed");
        $('.change img').each(function () {
          this.src= "/assets/background2-6492c83fc5943157d9debcd80089e7f7.jpg";
        });
        // swap out small displays for xs displays on smaller screens
        $('.display').removeClass('XS');
        $('.display').addClass('S');
        $('.flapper').css('font-weight', 800);
      }
      else if(window.matchMedia(imgsmall).matches) {
        // the wall
        $('.full-screen-img').css("background-image", "url(/assets/background1-a9d15ff618c71c16cc1cc81dc8d8f2f1.jpg) no-repeat center center fixed");
        $('.change img').each(function () {
          this.src= "/assets/background1-a9d15ff618c71c16cc1cc81dc8d8f2f1.jpg";
        });
        // swap out small displays for xs displays on smaller screens
        $('.display').removeClass('S');
        $('.display').addClass('XS');
        $('.flapper').css('font-weight', 400);
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