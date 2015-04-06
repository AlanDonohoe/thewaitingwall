$(function() {
  $("#flapper-display-area").hide();
  $("#message_review").click(function() {
    $("#flapper-display-area").show();
    $('html, body').animate({
      scrollTop: $("#flapper-display-area").offset().top
    }, 2000);
  });
  $("#edit_message").click(function() {
    $("#flapper-display-area").show();
    $('html, body').animate({
      scrollTop: $("#message_message_text").offset().top
    }, 2000);
  });
});
