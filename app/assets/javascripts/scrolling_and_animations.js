$(function() {
  $("#flapper-display-area").hide();
  $("#message_review").click(function() {
    $("#flapper-display-area").show();
    $('html, body').animate({
      scrollTop: $("#flapper-display-area").offset().top
    }, 700);
  });
  $("#edit_message").click(function() {
    $('html, body').animate({
      scrollTop: $(".nav-wrapper").offset().top
    }, 500);
  });
});
