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
  hideHeaderLinks();
});


function sendAjax(event) {
  var url = event.toElement.href;

  $.getJSON({
    url: url,
  }).done(function(response) {

    if(event.toElement.className == '') {
      // loads col 1 -categories
      loadIndexResponse(response);
    }else if (event.toElement.className.includes('index_link')){
      loadCol2(response);
    }else if (event.toElement.className.includes('col_2_link')){
      loadCol3(response);
    }
  });
}

function requestForm(event) {
  var url = event.toElement.href;
  var form_html;

  $.get(url, function(data) {
    $(document.body).append('<div id="form"></div>');
    $('div#form').append(data);
    addCloseButton($('div#form'));

    changeBackground('black');
    $('div#form').show(200);
  });

}

function sendForm(form) {
  data = form.serialize();

  $.ajax({
    type: 'post',
    url: form.attr('action'),
    data: data,
    success: function(response){
      refreshPage();
      alert("Thanks for making the community better!");
    }
  });
}

function refreshPage() {
  location.reload(true);
}
// should use createElement(), and setAttribute() to be less explicit
function appendCreateButton(columnId, response) {
  if((columnId == "#col_1") && (response.users == undefined)) {
    $(columnId).append('<div class="new_object"><a href="/categories/new" class="new_object_link">New!</a></div>');
  }else if(columnId == "#col_2") {
    $(columnId).append('<div class="new_object"><a href="/categories/' + response.category.id + '/subjects/new" class="new_object_link">New!</a></div>');
  }else if(columnId == "#col_3") {
    $(columnId).append('<div class="new_object"><a href="/categories/' + response.subject.category_id + '/subjects/' + response.subject.id + '/resources/new" class="new_object_link">New!</a></div>');
  }
}

function hideHeaderLinks() {
  $('a#home').css('display','none');
}

function changeBackground(color) {
   $('body').prepend('<div id="form_background"></div>');
   $('div#form_background').css('background-color', color);
}

function addCloseButton(form) {
  var img_src = 'assets/close_button.png'

  if(form) {
    $('#form #content').prepend('<img id="close_button" src="'+ img_src +'" />');
  }
}

function removeForm() {
  refreshPage()
  // below gets several form responses from rails...
  // $('#form').remove();
  // $('#form_background').remove();
}
function updateDropDowns(event) {
//   var category_id = $("#category_id option:selected").val();
//
//     // $('#category_subjects_attributes_0_id').empty();
//
//
//     var options =
//     $('#subjects_datalist').filter(function(options){
//       // var selected_subjects = $(options).select {|sub| sub == category_id }
// debugger;
//       // return $(this).attr("value") == (s_id.cat_id == $("#category_id option:selected").val())
//     }).clone();
//
//     $("#category_subjects_attributes_0_id").append(options);

}
