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

  $(document.body).on('click', '#back', function(event) {
    location.reload(true);
  });

  // $(document.body).on('click', 'a#home', function(event) {
  //   event.preventDefault();
  //   location.reload(true);
  // });

///////////////////////////////////////
// col_2
  $(document.body).on('click', '.index_link', function(event) {
    $('.index_link').css('background', '#c9c9c9')
    $(event.toElement).css('background','LightSkyBlue');
    sendAjax(event);
    event.preventDefault();
  });
// col_3
  $(document.body).on('click', '.col_2_link', function(event) {
    $('.col_2_link').css('background', '#c9c9c9')
    $(event.toElement).css('background', 'LightSkyBlue');
    sendAjax(event);
    event.preventDefault();
  });
/////////////////////
  $('#build_tree').on('click', function(event) {
    requestForm(event);
    event.preventDefault();
  });

  $(document.body).on('click', '#submit_form', function(event) {
    sendForm($('form'));
    event.preventDefault();
  });

  $(document.body).on('click', 'a.edit', function(event) {
    event.preventDefault();
    requestForm(event);
  });
}

function sendAjax(event) {
  var url = event.toElement.href;

  $.getJSON({
    url: url,
  }).done(function(response) {

    if(event.toElement.className == '') {
      loadIndexResponse(response);
    }else if (event.toElement.className.includes('index_link')){
      loadCol2(response);
    }else{
      loadCol3(response);
    }
  });
}

function requestForm(event) {
  var url = event.toElement.href;
  var form_html;
  var jqhr = $.get(url, function(data) {

    $(document.body).append('<div id="form"></div>');
    form_html = $(data)[45]; // must be better way to parse data object.
    $('div#form').append(data);

    $('div#form').show(200);

  });

}

function sendForm(form) {
  data = form.serialize();
  // {
     // look to call $(form).serialize

    // 'authenticity_token': $('input[name="authenticity_token"]').attr('value'),
    // 'category': {
    //   'name': $('input[id="category_name"]').val(),
    //   'id': $('select[id="category_id"]').val(),
    //   'subjects_attributes': {
    //     '0': {
    //       'name': $('input[id="category_subjects_attributes_0_name"]').val(),
    //       'user_id': $('#subject_user_id').val(),
    //       'id': $('select[id="category_subjects_attributes_0_id"]').val(),
    //       'resources_attributes': {
    //         '0': {
    //           'name': $('input[id="category_subjects_attributes_0_resources_attributes_0_name"]').val(),
    //           'url': $('input[id="category_subjects_attributes_0_resources_attributes_0_url"]').val(),
    //           'description': $('input[id="category_subjects_attributes_0_resources_attributes_0_description"]').text(),
    //           'price_per_month': $('input[id="category_subjects_attributes_0_resources_attributes_0_price_per_month"]').val(),
    //           'user_id': $('#resource_user_id').val()
    //         }
    //       }
    //     }
    //   }
    // }
  // }

  $.ajax({
    type: 'post',
    url: form.attr('action'),
    data: data,
    success: function(response){
      refreshPage();
    }
  })
}

function refreshPage() {
  location.reload(true);
  alert("Thanks for making the community better!");
}

function hideHeaderLinks() {
  $('a#home').css('display','none');
}
