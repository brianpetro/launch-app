// i: parameter name
// o: parameter value
var getParameterByName = function (name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
  results = regex.exec(location.search);
  return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// default tracking uses 'i' parameter to set user_tracker
// set var i_tracker to value of 'i' parameter
var i_tracker = getParameterByName('i');
$(function(){
  // update hidden input if tracker value present
  if ((i_tracker.length > 0) && (i_tracker.length < 200)){
    $('#user_tracker').val(i_tracker);
  }
})
