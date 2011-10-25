// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  
  if ($(".flashy").length) {
    $(".flashy").delay(5000).slideUp();
  }
  
  $("#user_tag_tokens").tokenInput("/tags.json", {
    crossDomain: false,
    prePopulate: $("#user_tag_tokens").data("pre"),
    theme: "facebook"
  });
  
  $("#change_password_link").click(function() {
    //$("#change_password").toggleClass("hidden");
    $("#change_password").slideToggle(200);
  });
  
});