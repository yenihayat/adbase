$(document).ready(function() {
  // Hide flash messages.
  setTimeout(function() {
    $("#message, #form-errors").fadeOut('slow')
  }, 5000);

  // Toggle ad expiration options.
  $("input#expire-chk").click(toggleExpireOptions);

  // Remove select field and check _destroy.
  $("a.remove-field").click(function(event) {
        $(this).prev().val('1');
        $(this).parent().fadeOut('fast')
  });
});

function toggleExpireOptions() {
  if ($('input#expire-chk').is(':checked') == true) {
    $(".expiration-options").fadeIn('slow')
  } else {
    $(".expiration-options").fadeOut('slow')
  };
}