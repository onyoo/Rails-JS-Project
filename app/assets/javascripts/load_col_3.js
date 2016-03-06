function loadCol3(response) {
  clearCol3();
  (response.subject.resources).forEach( function(subject) {
    $('#col_3_list').append(createListItem(subject));
  })
}

function clearCol3() {
  $('#col_3_list').children().remove();
}
