$(function() {
  $("#flapper-display-area").hide();
  $("#message_review").click(function() {
    $("#message_review").hide();
    $("#flapper-display-area").show();
    $('html, body').animate({
      scrollTop: $("#flapper-display-area").offset().top
    }, 700);
  });
  $("#edit_message").click(function() {
    $("#message_review").show();
    $('html, body').animate({
      scrollTop: $(".nav-wrapper").offset().top
    }, 500);
  });
});
