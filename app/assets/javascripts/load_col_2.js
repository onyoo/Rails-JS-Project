function loadCol2(response) {
  clearCol2();
  clearCol3();
  (response.category.subjects).forEach( function(subject) {
    $('#col_2').append(createListItem(subject));
  })
  appendCreateButton('#col_2', response);
}

function clearCol2() {
  $('#col_2').children().remove();
}
