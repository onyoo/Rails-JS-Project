function loadCol3(response) {
  clearCol3();
  (response.subject.resources).forEach( function(subject) {
    $('#col_3').append(createListItem(subject));
  })
}

function clearCol3() {
  $('#col_3').children().remove();
}
