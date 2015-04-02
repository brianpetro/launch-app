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

// remove URL parameter
// ref: http://stackoverflow.com/a/1634841/1885896
var removeUrlParameter = function (url, parameter) {
  var urlparts= url.split('?');   
  if (urlparts.length>=2) {
    var prefix= encodeURIComponent(parameter)+'=';
    var pars= urlparts[1].split(/[&;]/g);
    for (var i= pars.length; i-- > 0;) { 
      if (pars[i].lastIndexOf(prefix, 0) !== -1) {  
        pars.splice(i, 1);
      }
    }
    url= urlparts[0]+'?'+pars.join('&');
    return url;
  } else {
    return url;
  }
}
var clearAlerts = function () {
  // clear all past alerts
  $('.alert').text('').hide();
}

// runs block/function after jQuery loads
$(function(){

  if ((i_tracker.length > 0) && (i_tracker.length < 200)){
    // update hidden input if tracker value present
    $('#user_tracker').val(i_tracker);
    // store tracking cookie for 3 days
    // ref: https://github.com/carhartl/jquery-cookie
    $.cookie('i_track', i_tracker, { expires: 3 });
    // remove 'i' parameter for cleaner presentation
    var clean_url = removeUrlParameter(location.href, 'i');
    // don't leave a trailing question mark if removing the only param
    clean_url = clean_url.replace(/\?+$/, "");
    // change URL without reloading or adding page to history
    history.replaceState({}, '', clean_url);
  }

  // set form tracking input if tracking cookie present
  var i_track_cookie = $.cookie('i_track');
  if (typeof i_track_cookie !== undefined) {
    $('#user_tracker').val(i_track_cookie);
  }

  // uses jquery-UJS remote form submission
  // ref: https://github.com/rails/jquery-ujs/wiki
  $('form#new_user').on('ajax:success', function(event, data, status, xhr) {
    clearAlerts();
    // show share links
    $('#share_links').show();
    // hide form
    $(this).hide();
    // build error message
    var success_message = 'Confirm your email('+data['email']+') to complete request.';
    // append to alert-info and show alert
    $('.alert-info').append(success_message).show();
  });
  $('form#new_user').on('ajax:error', function(event, xhr, status, error) {
    clearAlerts();
    // parse error response
    var error_json = JSON.parse(xhr.responseText);
    // build error message
    var error_message = 'Submit failed: Email '+error_json['email'][0]+'.';
    // append to alert-danger and show alert
    $('.alert-danger').append(error_message).show();
  });

})

