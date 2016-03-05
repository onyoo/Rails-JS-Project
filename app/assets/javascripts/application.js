// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  clickListeners();
});


function clickListeners() {
  $('a[href$="categories"]').on('click', function(event) {
    event.preventDefault();
    sendAjax(event);
  });

  $('a[href$="subjects"]').on('click', function(event) {
    event.preventDefault();
    sendAjax(event);
  });

  $('a[href$="resources"]').on('click', function(event) {
    event.preventDefault();
    sendAjax(event);
  });

  $('a[href$="users"]').on('click', function(event) {
    event.preventDefault();
    sendAjax(event);
  });

///////////////////////////////////////

  $(document.body).on('click', '.index_link', function(event) {
    event.preventDefault();
    sendAjax(event);
  });

}

function sendAjax(event) {
  var url = event.toElement.href;

  $.getJSON({
    url: url,
  }).done(function(response) {
  if(event.toElement.className != 'index_link') {
    loadIndexResponse(response);
  }else{
    loadCol2(response);
  }
  });
}
