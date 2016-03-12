function loadCol3(response) {
  clearCol3();
  (response.subject.resources).forEach( function(subject) {
    $('#col_3').append(createListItem(subject));
  });
  appendCreateButton('#col_3', response);
}

function clearCol3() {
  $('#col_3').children().remove();
}

function showResource(event) {
  var url = event.toElement.href;
  var form_html;

  $.get(url, function(data) {
    $(document.body).append('<div id="show_resource"></div>');
debugger;
    resource_html = $(data)[37];
    $('#show_resource').append(resource_html);

  });
  changeBackground('black');
}
