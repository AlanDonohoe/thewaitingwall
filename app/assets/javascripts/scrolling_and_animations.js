$(function() {
  $("#message_message_text").focus();
  $("#flapper-display-area").hide();
  $("#message_review").click(function() {
    // $("#message_review").hide();
    $("#flapper-display-area").css("display", "inline");
    $('html, body').animate({
      scrollTop: $("#flapper-display-area").offset().top
    }, 1000);
  });
  $("#edit_message").click(function() {
    // $("#message_review").show();
    // $("#message_message_text").focus();
    $('html, body').animate({
      scrollTop: $(".nav-wrapper").offset().top
    }, 2000);

  });
});
