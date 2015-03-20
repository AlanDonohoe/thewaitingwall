$(function() {
  $(".the-what-link").click(function() {
    $(this).parent().addClass('active');
    $(this).parent().siblings().removeClass('active');
    $("#main-content").replaceWith("<div id=\"main-content\"><h3>The What?</h3><p>Based on Jerusalem's Waling Wall, where since the 4th Century people have anonymously posted their prayers of hope, concerns or sought forgiveness by confessing their wrong-doings.</p></div>");
  });

  $(".the-why-link").click(function() {
    $(this).parent().addClass('active');
    $(this).parent().siblings().removeClass('active');
    $("#main-content").replaceWith("<div id=\"main-content\"><h3>The Why?</h3><p>In a secular world....</p></div>");
  });

  $(".the-who-link").click(function() {
    $(this).parent().addClass('active');
    $(this).parent().siblings().removeClass('active');
    $("#main-content").replaceWith("<div id=\"main-content\"><h3>The Who?</h3><p>Free The Trees and Alain de Botton</p></div>");
  });
});