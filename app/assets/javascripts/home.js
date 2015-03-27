// i: parameter name
// o: parameter value
var getParameterByName = function (name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
  results = regex.exec(location.search);
  // returns empty string if parameter is not present
  return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// default tracking uses 'i' parameter to set user_tracker
// set var i_tracker to value of 'i' parameter
var i_tracker = getParameterByName('i');

// display messages on cached pages via URL 'msg' parameter
var url_msg = getParameterByName('msg');
$(function(){
  // update hidden input if tracker value present
  if ((i_tracker.length > 0) && (i_tracker.length < 200)){
    $('#user_tracker').val(i_tracker);
  }

  // if URL param 'msg' is present, show in primary panel
  if (url_msg.length > 0){
    $('.panel-primary .panel-body .alert').text(url_msg).show();
  }
})
