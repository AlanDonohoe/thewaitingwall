$(function() {
  $(".button-collapse").sideNav();
  $(".the-what-link").click(function() {
    $("#main-content").replaceWith("<div id=\"main-content\"><h3>The What?</h3><p>It’s often when waiting, for something or someone, that there is the time to reflect.  That can be uncomfortable or it can be a blessing: a break from rushing around where we are never quite alone with our thoughts.  </p> <br/> <p> Inspired by the author Alain de Botton's secular version of Jerusalem's Wailing Wall, The Waiting Wall allows you to anonymously share your hopes, problems and confessions. </p><br/><p>Let worries, regrets and hopes bubble to the surface. Share them with the wall so we can all realise that none of us are alone in our own world of problems.</p></div>");
  });

  $(".the-who-link").click(function() {
    $("#main-content").replaceWith("<div id=\"main-content\"><h3>The Who?</h3><p>We were inspired by Alain de Botton's excellent book: Religion for Atheists and moved by digital artist Witchoria's beautiful pieces on the different stages of grief. As a backdrop, we used photos taken of Brighton whilst battered by a storm or when enveloped in a fog from the sea.</p><br/><p>We, Free The Trees, have created a secular version of The Wailing Wall envisioned by Alain de Botton.</p><br/><p>Learn more: <a href=\"http://freethetrees.co.uk/\">Free The Trees</a> / <a href=\"http://alaindebotton.com/religion\">Religion for Atheists</a> / <a href=\"https://ello.co/witchoria/post/DBs5UxirltuGyR1RrKL_Zw\">Witchoria: Different Stages of Grief </a></p></div>");
  });
});