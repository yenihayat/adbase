$(document).ready(function() {
  $("#login table.login a.forgot-password").click(showForgotPassword);
  $("#login table.forgot-password a.login").click(showLogin);

  setTimeout(function() {
    $("#message").slideUp(300);
  }, 5000);

});

function showForgotPassword() {
  $("#login").slideUp(300);
  setTimeout("$('#login table.login').hide();", 300);
  setTimeout("$('#login table.forgot-password').show();", 300);
  $("#login").slideDown(300);
}

function showLogin() {
  $("#login").slideUp(300);
  setTimeout("$('#login table.forgot-password').hide();", 300);
  setTimeout("$('#login table.login').show();", 300);
  $("#login").slideDown(300);
}