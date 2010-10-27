$(document).ready(function() {
  setTimeout(function() {
    $("#message, #form-errors").fadeOut('slow')
  }, 5000);
  $("input#expire-chk").click(toggleExpireOptions);
});

function toggleExpireOptions() {
  if ($('input#expire-chk').is(':checked') == true) {
  $(".expiration-options").fadeIn('slow')
  } else {
  $(".expiration-options").fadeOut('slow')
  };
}