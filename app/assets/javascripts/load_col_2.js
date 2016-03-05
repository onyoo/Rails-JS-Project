function loadCol2(response) {

  clearCol2();
  (response.category.subjects).forEach( function(subject) {
    $('#col_2_list').append(createListItem(subject));
  })
}

function clearCol2() {
  $('#col_2_list').children().remove();
}
