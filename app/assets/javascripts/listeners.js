
function clickListeners() {
// Home index listeners
  $('a[href$="categories"]').on('click', function(event) {
    sendAjax(event);
    event.preventDefault();
  });

  $('a[href$="subjects"]').on('click', function(event) {
    sendAjax(event);
    event.preventDefault();
  });

  $('a[href$="resources"]').on('click', function(event) {
    sendAjax(event);
    event.preventDefault();
  });

  $('a[href$="users"]').on('click', function(event) {
    sendAjax(event);
    event.preventDefault();
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
// show resource
  $(document.body).on('click', '.col_3_link', function(event) {
    showResource(event);
    event.preventDefault();
  });

/////////////////////

  $(document.body).on('click', '#back', function(event) {
    location.reload(true);
  });

  $('#build_tree').on('click', function(event) {
    requestForm(event);
    event.preventDefault();
  });

  $(document.body).on('click', '#submit_form', function(event) {
    sendForm($('form'));
    event.preventDefault();
    event.stopPropagation();
  });

  $(document.body).on('click', 'a.edit', function(event) {
    event.preventDefault();
    requestForm(event);
  });

  $(document.body).on('click', 'a.new_object', function(event) {
    requestForm(event);
    event.preventDefault();
  });

  $(document.body).on('click', 'a.new_object_link', function(event) {
    requestForm(event);
    event.preventDefault();
  });

  $('#close_button').on('click', function() {
    removeForm();
  });

  $(document.body).on('click', '#form_background', function() {
    removeForm();
  });

  $('#category_id').on('change', function(event) {
    updateDropDowns(event);
  });

}
